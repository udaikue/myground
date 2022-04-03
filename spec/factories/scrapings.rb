# frozen_string_literal: true

FactoryBot.define do
  factory :scraping do
    url { 'https://baseball-freak.com/game/' }
    game_date { Time.zone.today }
    done { 'false' }
  end
end
