# frozen_string_literal: true

class DiariesController < ApplicationController
  def index
    @diaries = Diary.all
  end

  def show; end

  def new
    @diary = Diary.new
  end

  def create
    @diary = Diary.new(diary_params)

    if @diary.save
      redirect_to diaries_path
    else
      render :new
    end
  end

  def edit; end

  def update; end

  def destroy; end

  private

  def diary_params
    params.require(:diary).permit(:comment, :open)
  end
end
