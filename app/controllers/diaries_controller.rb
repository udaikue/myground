# frozen_string_literal: true

class DiariesController < ApplicationController
  def index
    @diaries = Diary.all
  end

  def show
    @diary = Diary.find(params[:id])
    @game = Game.find(@diary.game_id)
    @news = News.where("diary_id = ?", params[:id])
    @game_wday = day_of_week
  end

  def new ;end

  def create ;end

  def edit
    @diary = Diary.find(params[:id])
  end

  def update
    @diary = Diary.find(params[:id])

    if @diary.update(diary_params)
      redirect_to diaries_path
    else
      render :edit
    end
  end

  def destroy
    diary = Diary.find(params[:id])
    diary.destroy
    redirect_to diaries_path
  end

  private

  def day_of_week
    day_of_week = %w[日 月 火 水 木 金 土]
    day_of_week[@game.date.wday]
  end

  def diary_params
    params.require(:diary).permit(:comment, :published)
  end
end
