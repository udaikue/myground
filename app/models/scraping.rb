# frozen_string_literal: true

class Scraping < ApplicationRecord
  validates :url, presence: true
  validates :game_date, presence: true

  scope :not_done, -> { where(game_date: Date.current, done: false) }
end
