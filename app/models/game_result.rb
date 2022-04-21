# frozen_string_literal: true

require 'open-uri'
require 'net/http'

class GameResult
  def responsed_urls
    scrapings = Scraping.not_done

    responsed_urls = []
    scrapings.each do |scraping|
      response = Net::HTTP.get_response(URI.parse(scraping.url))
      responsed_urls << scraping.url if response.code == '200'
    end
    responsed_urls
  end

  def create_games(urls)
    urls.each do |url|
      html = URI.parse(url).open.read
      @doc = Nokogiri::HTML.parse(html)

      @game = Game.new

      fetch_game_result
      set_scores
      # スコアボードに得点が入っていない場合は試合が終了していない
      next if game_not_end?

      set_game_date
      convert_ballpark_name_to_id
      convert_team_name_to_id
      set_game_records

      @game.save
      update_scraping_flag(url) if create_scores
    end
  end

  def fetch_game_result
    @scores = []
    @doc.css('.scoreboard tr').each do |team|
      team.css('td').each do |score|
        @scores << score.text
      end
      @scores << nil
    end

    @ballpark_name = @doc.css('.sb-info').text.strip.split(' ').first

    @score_board = []
    @doc.css('.scoreboard tr').each do |team|
      @score_board << team.text
    end

    # @records = [勝利投手, 敗戦投手, セーブ投手, ビジター本塁打, ホーム本塁打]
    @records = []
    @doc.css('.pchr td').each do |record|
      @records << record.text
    end
  end

  def set_scores
    @game.score_visitor = @scores.split(nil)[1][-3]
    @game.score_home = @scores.split(nil)[2][-3]
    @game.hits_visitor = @scores.split(nil)[1][-2]
    @game.hits_home = @scores.split(nil)[2][-2]
    @game.errors_visitor = @scores.split(nil)[1][-1]
    @game.errors_home = @scores.split(nil)[2][-1]
  end

  def game_not_end?
    @scores.split(nil)[1][-3] == '' || @scores.split(nil)[1][-3].nil? || @scores.split(nil)[1][-3] == '&nbsp'
  end

  def set_game_date
    @game.date = Date.current
  end

  def convert_ballpark_name_to_id
    @game.ballpark_id = Ballpark.find_by(name: @ballpark_name).id
  end

  def convert_team_name_to_id
    team_visitor_name = @score_board.drop(1)[0].split(nil)[0]
    @game.team_visitor_id = Team.find_by(name: team_visitor_name).id
    team_home_name = @score_board.drop(1)[1].split(nil)[0]
    @game.team_home_id = Team.find_by(name: team_home_name).id
  end

  def set_game_records
    @game.winning_pitcher = @records[0].tr('　', '(').concat(')') if @records[0].present?
    @game.losing_pitcher = @records[1].tr('　', '(').concat(')') if @records[1].present?
    @game.saving_pitcher = @records[2].tr('　', '(').concat(')') if @records[2].present?
    @game.homerun_visitor = @records[3].gsub(/　|\[|\]/, '　' => ' ', '[' => '(', ']' => ')') if @records[3].present?
    @game.homerun_home = @records[4].gsub(/　|\[|\]/, '　' => ' ', '[' => '(', ']' => ')') if @records[4].present?
  end

  def create_scores
    innings = []
    innings << @scores.split(nil)[1][0..-4] << @scores.split(nil)[2][0..-4]

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
    scraping = Scraping.find_by(url: url)
    scraping.update(done: true)
  end
end
