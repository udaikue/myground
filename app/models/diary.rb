# frozen_string_literal: true

class Diary < ApplicationRecord
  has_one :game
  has_many :news
end
