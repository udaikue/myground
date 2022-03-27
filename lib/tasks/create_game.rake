# frozen_string_literal: true

require_relative '../card'
require_relative '../url'
require_relative '../db'

desc 'Heroku scheduler add-on'
task :create_game => :environment do
  card = Card.new
  URL.new(card.today_games)
end
