# frozen_string_literal: true

require_relative '../url'
require_relative '../db'
require_relative '../search'
require_relative '../result'

desc 'Heroku scheduler add-on'
task update_scraping_and_game: :environment do
  url = URL.new
  # 試合がなければその後の処理は実行しない
  next if url.today_cards.empty?

  DB.new(url.today_cards)
  search = Search.new
  result = Result.new
  result.create_games(search.responsed_urls)
end

task update_game: :environment do
  search = Search.new
  # scrapingsテーブルに未登録分がなければその後の処理は実行しない
  next if search.scrapings.empty?

  result = Result.new
  result.create_games(search.responsed_urls)
end
