# frozen_string_literal: true

class Diary < ApplicationRecord
  has_one :user
  has_one :game
  has_many :links, dependent: :destroy
  accepts_nested_attributes_for :links, allow_destroy: true

  scope :recent, -> { order(created_at: :desc) }
end
