# frozen_string_literal: true

class Diary < ApplicationRecord
  belongs_to :user
  belongs_to :game
  has_many :links, dependent: :destroy
  accepts_nested_attributes_for :links, allow_destroy: true

  def previous
    Diary.where('id < ? and user_id = ?', id, user_id).order(id: :desc).first
  end

  def next
    Diary.where('id > ? and user_id = ?', id, user_id).order(id: :asc).first
  end
end
