class News < ApplicationRecord
  belongs_to :diary
  belongs_to :link
end
