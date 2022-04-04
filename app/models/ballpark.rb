# frozen_string_literal: true

class Ballpark < ApplicationRecord
  has_many :games, dependent: :destroy
end
