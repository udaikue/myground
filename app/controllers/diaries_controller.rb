# frozen_string_literal: true

class DiariesController < ApplicationController
  def index
    @diaries = Diary.order(:id)
  end

  def show
    @diary = Diary.find(params[:id])
    @game = Game.find(@diary.game_id)
    @game_wday = day_of_week
  end

  def new ;end

  def create
    @diary = Diary.new(diary_params)
    if @diary.save!
      redirect_to diaries_path
    else
      render :new
    end
  end

  def edit
    @diary = Diary.find(params[:id])
  end

  def update
    @diary = Diary.find(params[:id])

    if @diary.update!(diary_params)
      redirect_to diary_path(@diary)
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
    params.require(:diary).permit(:id, :comment, :published, :game_id, links_attributes: [:id, :url, :title, :_destroy,])
  end
end
