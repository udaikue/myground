FactoryBot.define do
  factory :user do
    id { '100' }
    username { 'username' }
    email { 'user@example.com' }
    password { 'password' }
  end
end
