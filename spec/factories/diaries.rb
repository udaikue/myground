# frozen_string_literal: true

FactoryBot.define do
  factory :diary do
    comment { '床田よかった！坂倉と小園好調！' }
    published { 'true' }
    
    user
    game
  end
end
