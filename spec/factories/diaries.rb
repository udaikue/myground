# frozen_string_literal: true

FactoryBot.define do
  factory :diary do
    comment { '菊池の守備がいい！' }
    published { 'true' }
  end
end
