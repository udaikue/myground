FactoryBot.define do
  factory :game do
    id { '123456789' }
    date { Date.today }
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
    ballpark_id { '100' }
    team_home_id { '200' }
    team_visitor_id { '100' }
  end
end
