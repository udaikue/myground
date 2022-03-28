# frozen_string_literal: true

require 'open-uri'
require 'nokogiri'

class Result
  def initialize(urls)
    urls.each do |url|
      html = URI.open(url).read
      doc = Nokogiri::HTML.parse(html)

      game = Game.new

      # スコアを取得
      scores = []
      doc.css('.scoreboard tr').each do |team|
        team.css('td').each do |score|
          scores << score.text
        end
        scores << nil
      end

      # スコアボードの得点がnilの場合は試合が終了していないとみなす
      # 次の試合へ処理を進める
      next unless scores.split(nil)[1][-3]

      # scoresテーブル用
      innings = []
      innings << scores.split(nil)[1][0..-4] << scores.split(nil)[2][0..-4]

      game.score_visitor = scores.split(nil)[1][-3]
      game.score_home = scores.split(nil)[2][-3]
      game.hits_visitor = scores.split(nil)[1][-2]
      game.hits_home = scores.split(nil)[2][-2]
      game.errors_visitor = scores.split(nil)[1][-1]
      game.errors_home = scores.split(nil)[2][-1]

      # 試合日と場所を取得
      # game.date = DateTime.now
      game.date = '2022-3-27'
      ballpark_name = doc.css('.sb-info').text.strip.split(' ').first
      game.ballpark_id = Ballpark.find_by(name: ballpark_name).id

      score_board = []

      # チーム名を取得
      doc.css('.scoreboard tr').each do |team|
        score_board << team.text
      end

      team_visitor_name = score_board.drop(1)[0].split(nil)[0]
      game.team_visitor_id = Team.find_by(name: team_visitor_name).id
      team_home_name = score_board.drop(1)[1].split(nil)[0]
      game.team_home_id = Team.find_by(name: team_home_name).id

      # ピッチャー、ホームラン記録を取得
      records = []
      doc.css('.pchr td').each do |record|
        records << record.text
      end

      # records = [勝利投手, 敗戦投手, セーブ投手, ビジター本塁打, ホーム本塁打]
      # それぞれの項目でnullがありえる
      if records[0].present?
        game.winning_pitcher = records[0].gsub('　', '(').concat(')')
      end
      if records[1].present?
        game.losing_pitcher = records[1].gsub('　', '(').concat(')')
      end
      if records[2].present?
        game.saving_pitcher = records[2].gsub('　', '(').concat(')')
      end
      if records[3].present?
        game.homerun_visitor = records[3].gsub(/　|\[|\]/, '　' => ' ', '[' => '(', ']' => ')')
      end
      if records[4].present?
        game.homerun_home = records[4].gsub(/　|\[|\]/, '　' => ' ', '[' => '(', ']' => ')')
      end

      game.save

      create_scores(innings)
      update_scraping_flag(url)
    end
  end

  def create_scores(innings)
    # scoresテーブルにデータを保存
    innings.transpose.each_with_index do |inning, index|
      score = Score.new
      score.game_id = Game.last.id
      score.inning = index + 1
      score.visitor = inning[0]
      score.home = inning[1]
      score.save
    end
  end

  def update_scraping_flag(url)
      # scrapingsテーブルのdoneをtrueにする
      scraping = Scraping.find_by(url: url)
      scraping.done = true
      scraping.save
  end
end
