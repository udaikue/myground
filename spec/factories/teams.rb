FactoryBot.define do
  factory :carp, class: Team do
    id { '100' }
    league_id { '0' }
    name { '広島' }
  end

  factory :marines, class: Team do
    id { '200' }
    league_id { '1' }
    name { 'ロッテ' }
  end
end
