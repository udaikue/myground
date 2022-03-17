FactoryBot.define do
  factory :suzuki_mc20220316, class: Diary do
    published { 'true' }
    comment { '坂倉と小園が好調。
      栗林が失点したのが気になるけど、床田よかった〜！' }
    association: user, factory: :suzuki
    association: game, factory: :mc20220316
  end
end
