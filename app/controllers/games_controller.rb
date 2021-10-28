class GamesController < ApplicationController
  def index
    @games = Game.order(:id)
    # @game_date = @games.select(:date).distinct
  end

  def show
    @game = Game.find(params[:id])
  end

  def create
  end

  private

  def game_params
    params.require(:game).permit(:date)
  end
end
