FactoryBot.define do
  factory :carp, class: Team do
    name { '広島' }
    league_id { '0' }
  end

  factory :marines, class: Team do
    name { 'ロッテ' }
    league_id { '1' }
  end
end
