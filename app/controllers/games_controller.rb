# frozen_string_literal: true

class GamesController < ApplicationController
  def index
    @games = Game.order(:id)
  end

  def show
    @game = Game.find(params[:id])
    @scores = Score.where("game_id = ?", params[:id])
  end

  def create
  end

  private

  def game_params
    params.require(:game).permit(:date)
  end
end
