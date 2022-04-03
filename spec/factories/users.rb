# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    username { 'username' }
    email { 'user@example.com' }
    password { 'password' }
  end
end
