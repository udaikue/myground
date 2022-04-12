# frozen_string_literal: true

FactoryBot.define do
  factory :carp, class: Team do
    league_id { '1' }
    name { '広島' }
  end

  factory :marines, class: Team do
    league_id { '2' }
    name { 'ロッテ' }
  end
end
