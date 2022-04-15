# frozen_string_literal: true

class WelcomeController < ApplicationController
  def index
    @diaries = Diary.published.limit(5)
  end
end
