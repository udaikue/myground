# frozen_string_literal: true

class DiariesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_diaries, only: %i[index]
  before_action :set_diary, only: %i[show edit update destroy]

  def index; end

  def show
    @game = Game.find(@diary.game_id)
    @game_wday = convert_day_of_week
    @scores = Score.where('game_id = ?', @diary.game_id)
    calculate_display_innings
  end

  def new; end

  def create
    @diary = Diary.new(diary_params)
    @diary.user_id = current_user.id

    if @diary.save
      redirect_to diaries_path(params[:username]), notice: '日記を登録しました'
    else
      render :new
    end
  end

  def edit; end

  def update
    if @diary.update(diary_params)
      redirect_to diary_path(params[:username]), notice: '日記を更新しました'
    else
      render :edit
    end
  end

  def destroy
    @diary.destroy
    redirect_to diaries_path(params[:username]), notice: '日記を削除しました'
  end

  private

  def convert_day_of_week
    day_of_week = %w[日 月 火 水 木 金 土]
    day_of_week[@game.date.wday]
  end

  def calculate_display_innings
    @display_innings = [9, @scores.length].max
  end

  def set_diary
    @diary = Diary.find(params[:id])
  end

  def set_diaries
    @diaries = Diary.where(user_id: current_user.id).order(id: :desc)
  end

  def diary_params
    params.require(:diary).permit(:id, :comment, :game_id, links_attributes: %i[id url title _destroy])
  end
end
