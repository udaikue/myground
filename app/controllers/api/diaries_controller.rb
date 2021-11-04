# frozen_string_literal: true

class API::DiariesController < API::BaseController
  def new
    @diary = Diary.new
    @games = Game.order(:id)
    render json: @games
  end
end
