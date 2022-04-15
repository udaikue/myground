# frozen_string_literal: true

class Scraping < ApplicationRecord
  validates :url, presence: true
  validates :game_date, presence: true
end
