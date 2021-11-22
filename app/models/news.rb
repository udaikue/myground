# frozen_string_literal: true

class News < ApplicationRecord
  belongs_to :diary
  belongs_to :link
end
