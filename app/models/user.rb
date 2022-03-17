# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :diaries, dependent: :destroy

  validates :username, uniqueness: true,
                       format: { with: /\A[a-zA-Z_0-9\d]+\z/ },
                       length: { minimum: 3, maximum: 25 },
                       username_not_reserved: true
end
