# frozen_string_literal: true

class Diary < ApplicationRecord
  belongs_to :user
  belongs_to :game
  has_many :links, dependent: :destroy
  accepts_nested_attributes_for :links, allow_destroy: true
end
