# frozen_string_literal: true

class Link < ApplicationRecord
  validates :url, presence: true
end
