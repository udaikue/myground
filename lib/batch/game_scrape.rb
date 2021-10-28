# frozen_string_literal: true

require 'date'

# 日付指定(本番では今日)
theday = Date.new(2021, 10, 10)
year = theday.year
month = theday.month
day = theday.day

# 指定日の対戦カードを取得
# (試合結果ページのURLを生成するため)
schedule = []

schedule_url = 'https://baseball-freak.com/game/'

schedule_html = URI.open(schedule_url).read
schedule_doc = Nokogiri::HTML.parse(schedule_html)

  # 今シーズンの全日程を取得:schedule
schedule_doc.css('.schedule tr').each do |date|
  schedule << date.css('td').text
end

  # 指定日の要素だけを取り出す
  # ○月▲日と(日)の'日'が日本ハムの略称とかぶるためgsubで削除
  # 球場名にもアルファベットが含まれるためdeleteで削除
theday_cards = schedule.grep(/#{month}月#{day}日/).to_s.gsub(/\d+月\d+日|\(日\)/, '').delete('a-z', 'A-C', 'E-Z').gsub(/巨|ヤ|D|中|阪|広|日|楽|西|ロ|オ|ソ/,
                                '巨' => 'g',
                                'ヤ' => 's',
                                'D' => 'yb',
                                '中' => 'd',
                                '阪' => 't',
                                '広' => 'c',
                                '日' => 'f',
                                '楽' => 'e',
                                '西' => 'l',
                                'ロ' => 'm',
                                'オ' => 'bs',
                                'ソ' => 'h')


# 対戦カードからURLを生成
urls = []

theday_cards.scan(/g|s|yb|d|t|c|f|e|l|m|bs|h/).each_slice(2) do |card|
  card_url = theday.strftime('%y%m%d') + card.join('-')
  url = "https://baseball-freak.com/game/#{card_url}.html"
  urls << url
end

# それぞれのURLから結果を取得しデータベースに保存する
urls.map do |url|
  html = URI.open(url).read
  doc = Nokogiri::HTML.parse(html)

  # 試合日と場所を取得
  game = Game.new
  game.date = theday
  game.ballpark = doc.css('.sb-info').text.strip.split(' ').first

  score_board = []

  # チーム名を取得
  doc.css('.scoreboard tr').each do |team|
    score_board << team.text
  end

  game.team_visitor = score_board.drop(1)[0].split(nil)[0]
  game.team_home = score_board.drop(1)[1].split(nil)[0]

  scores = []
  innings = []

  # スコアを取得
  doc.css('.scoreboard tr').each do |team|
    team.css('td').each do |score|
      scores << score.text
    end
    scores << nil
  end

    # scoresテーブルに保存するため
  innings << scores.split(nil)[1][0..-4] << scores.split(nil)[2][0..-4]

  game.score_visitor = scores.split(nil)[1][-3]
  game.score_home = scores.split(nil)[2][-3]
  game.hits_visitor = scores.split(nil)[1][-2]
  game.hits_home = scores.split(nil)[2][-2]
  game.errors_visitor = scores.split(nil)[1][-1]
  game.errors_home = scores.split(nil)[2][-1]

  # ピッチャー、ホームラン記録を取得
  records = []

  doc.css('.pchr td').each do |record|
    records << record.text
  end

    # records = [勝利投手, 敗戦投手, セーブ投手, ビジター本塁打, ホーム本塁打]
    # それぞれの項目でnullがありえる
  if !records[0].blank?
    game.winning_pitcher = records[0].gsub('　', '(').concat(')')
  end
  if !records[1].blank?
    game.losing_pitcher = records[1].gsub('　', '(').concat(')')
  end
  if !records[2].blank?
    game.saving_pitcher = records[2].gsub('　', '(').concat(')')
  end
  if !records[3].blank?
    game.homerun_visitor = records[3].gsub(/　|\[|\]/, '　' => ' ', '[' => '(', ']' => ')')
  end
  if !records[4].blank?
    game.homerun_home = records[4].gsub(/　|\[|\]/, '　' => ' ', '[' => '(', ']' => ')')
  end

  game.save

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
