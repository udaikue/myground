FactoryBot.define do
  factory :suzuki, class: User do
    username { 'suzuki' }
    email { 'suzuki@example.com' }
    password { 'testtest' }
    password_confirmation { 'testtest' }
  end
end
