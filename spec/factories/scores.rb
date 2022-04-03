# frozen_string_literal: true

FactoryBot.define do
  factory :score do
    inning { '1' }
    home { '2' }
    visitor { '0' }

    game
  end
end
