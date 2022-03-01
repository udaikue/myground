# frozen_string_literal: true

class API::ScoresController < API::BaseController
  def index
    @scores = Score.order(:id)
    render json: @scores
  end
end
