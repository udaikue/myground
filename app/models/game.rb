# frozen_string_literal: true

class Game < ApplicationRecord
  has_many :diaries, dependent: :destroy
end
