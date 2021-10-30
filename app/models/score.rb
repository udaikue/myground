class Score < ApplicationRecord
  belongs_to :game

  validates :inning, inclusion: { in: 1..12 }
end
