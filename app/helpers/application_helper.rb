# frozen_string_literal: true

module ApplicationHelper
  def header?
    user_signed_in? || params[:controller] == 'diaries' || params[:controller] == 'home'
  end

  def my_diaries_index?
    current_user&.username == params[:username] || !params[:username]
  end

  def my_diary?
    current_user&.username == params[:username]
  end

  def first_tab_active?
    request.path == '/diaries' || request.path == '/'
  end

  def index_game_date(game)
    "#{game.date.year}/#{game.date.month}/#{game.date.day}"
  end

  def index_game_card(game)
    "#{Team.find(game.team_home_id).name} #{game.score_home} - #{game.score_visitor} #{Team.find(game.team_visitor_id).name}"
  end

  def index_game_ballpark(game)
    "@#{Ballpark.find(game.ballpark_id).name}"
  end

  def index_diary_username(diary)
    User.find(diary.user_id).username
  end
end
