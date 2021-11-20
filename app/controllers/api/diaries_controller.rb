# frozen_string_literal: true

class API::DiariesController < API::BaseController
  def new
    @diary = Diary.new
    @games = Game.order(:id)
    render json: @games
  end

  def create
    @diary = Diary.new(diary_params)
    @link = Link.new(link_params)

    if @diary.save && @link.save
      redirect_to diaries_path, status: 302
    else
      render :new
    end

    news = News.new
    news.diary_id = @diary.id
    news.link_id = @link.id
    news.save
  end

  private

  def diary_params
    params.require(:diary).permit(:comment, :published, :game_id)
  end

  def link_params
    params.require(:link).permit(:url)
  end

end
