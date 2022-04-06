# frozen_string_literal: true

class WelcomeController < ApplicationController
  def index
    @diaries = Diary.where('published = ?', true).limit(5)
  end
end
