# frozen_string_literal: true

class API::GamesController < API::BaseController
  def index
    @games = Game.order(:id)
    render json: @games
  end
end
