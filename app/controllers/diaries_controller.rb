# frozen_string_literal: true

class DiariesController < ApplicationController
  before_action :set_diaries, only: %i[index]
  before_action :set_diary, only: %i[show edit update destroy]

  def index
    @q = current_user.diaries.ransack(params[:q])
    @diaries = @q.result(distinct: true).recent
  end

  def show
    @game = Game.find(@diary.game_id)
    @game_wday = set_day_of_week
    @scores = Score.where("game_id = ?", @diary.game_id)
    set_display_innings
  end

  def new ;end

  def create
    @diary = Diary.new(diary_params)
    @diary.user_id = current_user.id

    if @diary.save!
      redirect_to diaries_path(params[:username])
    else
      render :new
    end
  end

  def edit ;end

  def update
    if @diary.update!(diary_params)
      redirect_to diary_path(params[:username])
    else
      render :edit
    end
  end

  def destroy
    @diary.destroy
    redirect_to diaries_path(params[:username])
  end

  private

  def set_day_of_week
    day_of_week = %w[日 月 火 水 木 金 土]
    day_of_week[@game.date.wday]
  end

  def set_display_innings
    @display_innings = @scores.length >= 9 ? @scores.length : 9
  end

  def set_diary
    @diary = Diary.find(params[:id])
  end

  def set_diaries
    # if (current_user.present? && current_user.username == params[:username]) || params[:username].nil?
    #   @diaries = Diary.where("user_id = ?", current_user.id)
    # else
    #   @user = User.find_by(username: params[:username])
    #   @diaries = Diary.where("user_id = ? and published = ?", @user.id, true)
    # end
  end

  def diary_params
    params.require(:diary).permit(:id, :comment, :published, :game_id, links_attributes: [:id, :url, :title, :_destroy,])
  end
end
