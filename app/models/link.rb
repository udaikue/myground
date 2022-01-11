# frozen_string_literal: true

class Link < ApplicationRecord
  belongs_to :diary
  validates :url, presence: true
end
