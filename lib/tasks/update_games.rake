# frozen_string_literal: true

require_relative '../url'
require_relative '../db'
require_relative '../search'
require_relative '../result'

desc 'Heroku scheduler add-on'
task :update_scraping_and_game => :environment do
  url = URL.new
  DB.new(url.today_cards)
  search = Search.new
  search.responsed_urls
  Result.new(search.responsed_urls)
end

task :update_game => :environment do
  search = Search.new
  Result.new(search.responsed_urls)
end
