# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    @diaries = Diary.published
  end
end
