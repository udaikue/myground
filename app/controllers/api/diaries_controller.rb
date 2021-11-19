# frozen_string_literal: true

class API::DiariesController < API::BaseController
  def new
    @diary = Diary.new
    @games = Game.order(:id)
    render json: @games
  end

  def create
    @diary = Diary.new(diary_params)

    if @diary.save
      redirect_to diaries_path, status: 302
    else
      render :new
    end
  end

  private

  def diary_params
    params.require(:diary).permit(:comment, :published, :game_id)
  end
end
