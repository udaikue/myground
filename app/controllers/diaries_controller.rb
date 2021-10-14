# frozen_string_literal: true

class DiariesController < ApplicationController
  def index
    @diaries = Diary.all
  end

  def show; end

  def new; end

  def create; end

  def edit; end

  def update; end

  def destroy; end
end
