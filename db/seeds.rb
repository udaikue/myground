# frozen_string_literal: true

require 'active_record/fixtures'

ActiveRecord::FixtureSet.create_fixtures 'db/fixtures', %i[
  teams
  games
  ballparks
  diaries
]

User.create!(id: 1, email: 'test1@example.com', username: 'ohtani', password: 'testtest')
User.create!(id: 2, email: 'test2@example.com', username: 'suzuki', password: 'testtest')
User.create!(id: 3, email: 'test3@example.com', username: 'kuroda15', password: 'testtest')
