# frozen_string_literal: true

require_relative '../url'
require_relative '../db'
# require_relative '../search'
# require_relative '../scraping'

desc 'Heroku scheduler add-on'
task :update_scraping => :environment do
  url = URL.new
  DB.new(url.today_cards)
end
