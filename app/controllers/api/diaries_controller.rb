# frozen_string_literal: true

class API::DiariesController < API::BaseController
  def show
    @diary = Diary.find(params[:id])
    @game = Game.find(@diary.game_id)
    @game_wday = day_of_week
    render json: { diary: @diary, links: @diary.links }
  end

  private

  def day_of_week
    day_of_week = %w[日 月 火 水 木 金 土]
    day_of_week[@game.date.wday]
  end
end
