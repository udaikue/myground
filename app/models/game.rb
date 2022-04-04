# frozen_string_literal: true

class Game < ApplicationRecord
  belongs_to :ballpark
  belongs_to :team_home, class_name: 'Team', inverse_of: :games
  belongs_to :team_visitor, class_name: 'Team', inverse_of: :games
  has_many :diaries, dependent: :destroy
  has_many :scores, dependent: :destroy
end
