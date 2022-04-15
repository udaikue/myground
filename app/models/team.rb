# frozen_string_literal: true

class Team < ApplicationRecord
  has_many :games, dependent: :destroy
  validates :league_id, presence: true
  validates :name, presence: true
end
