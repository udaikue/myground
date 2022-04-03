# frozen_string_literal: true

FactoryBot.define do
  factory :link do
    url { 'https://baseball-freak.com/game/' }
    title { 'プロ野球Freak' }
    diary
  end
end
