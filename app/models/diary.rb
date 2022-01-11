# frozen_string_literal: true

class Diary < ApplicationRecord
  has_one :game
  has_many :links
  accepts_nested_attributes_for :links, allow_destroy: true
end
