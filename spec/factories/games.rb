# frozen_string_literal: true

FactoryBot.define do
  factory :game do
    id { '123456789' }
    date { Time.zone.today }
    score_home { '1' }
    score_visitor { '2' }
    hits_home { '4' }
    hits_visitor { '6' }
    errors_home { '0' }
    errors_visitor { '1' }
    winning_pitcher { '床田 (1勝0敗0S)' }
    losing_pitcher { '石川 (0勝2敗0S)' }
    saving_pitcher { '栗林 (0勝0敗1S)' }
    homerun_home { '' }
    homerun_visitor { '' }
    team_home { FactoryBot.create(:marines) }
    team_visitor { FactoryBot.create(:carp) }

    ballpark
  end
end
