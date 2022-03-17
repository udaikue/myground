FactoryBot.define do
  factory :mc20220316_1, class: Score do
    inning { '1' }
    home { '0' }
    visitor { '0' }
    association: game, factory: :mc20220316
  end

  factory :mc20220316_2, class: Score do
    inning { '2' }
    home { '0' }
    visitor { '0' }
    association: game, factory: :mc20220316
  end

  factory :mc20220316_3, class: Score do
    inning { '3' }
    home { '0' }
    visitor { '0' }
    association: game, factory: :mc20220316
  end

  factory :mc20220316_4, class: Score do
    inning { '4' }
    home { '0' }
    visitor { '1' }
    association: game, factory: :mc20220316
  end

  factory :mc20220316_5, class: Score do
    inning { '5' }
    home { '0' }
    visitor { '0' }
    association: game, factory: :mc20220316
  end

  factory :mc20220316_6, class: Score do
    inning { '6' }
    home { '0' }
    visitor { '0' }
    association: game, factory: :mc20220316
  end

  factory :mc20220316_7, class: Score do
    inning { '7' }
    home { '0' }
    visitor { '1' }
    association: game, factory: :mc20220316
  end

  factory :mc20220316_8, class: Score do
    inning { '8' }
    home { '0' }
    visitor { '0' }
    association: game, factory: :mc20220316
  end

  factory :mc20220316_9, class: Score do
    inning { '9' }
    home { '1' }
    visitor { '0' }
    association: game, factory: :mc20220316
  end
end
