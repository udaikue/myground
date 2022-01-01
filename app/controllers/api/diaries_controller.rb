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
      redirect_to diaries_path
    else
      render :new
    end

    links = [params[:link][:url].split(','), params[:link][:title].split(',')]

    links.map do |l|
      link = Link.new
      link.url = l[0]
      link.title = l[1]
      link.save
      news = News.new
      news.diary_id = @diary.id
      news.link_id = link.id
      news.save
    end
  end

  private

  def diary_params
    params.require(:diary).permit(:comment, :published, :game_id)
  end

  def link_params
    params.require(:link).permit(:url, :title)
  end

end
