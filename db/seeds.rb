# frozen_string_literal: true

require 'active_record/fixtures'

ActiveRecord::FixtureSet.create_fixtures 'db/fixtures', %i[
  teams
  ballparks
  games
  scores
  diaries
  links
]

User.create!(id: 100, email: 'test1@example.com', username: 'test_user1', password: 'password')
User.create!(id: 200, email: 'test2@example.com', username: 'test_user2', password: 'password')
