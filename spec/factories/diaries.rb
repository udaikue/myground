FactoryBot.define do
  factory :diary do
    comment { '床田よかった！坂倉と小園好調！' }
    published { 'true' }
    game_id { '123456789' }
    user_id { '100' }
  end
end
