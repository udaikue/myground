# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    @diaries = Diary.where("published = ?", true)
  end
end
