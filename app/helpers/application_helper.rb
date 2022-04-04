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
end
