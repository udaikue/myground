# frozen_string_literal: true

class API::DiariesController < API::BaseController
  def show
    @diary = Diary.find(params[:id])
    render json: { diary: @diary, links: @diary.links }
  end
end
