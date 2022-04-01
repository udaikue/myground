# frozen_string_literal: true

module ApplicationHelper
  def has_header?
    user_signed_in? || params[:controller] == 'diaries' || params[:controller] == 'home'
  end

  def my_diaries_index?
    return current_user&.username == params[:username] || !params[:username]
  end

  def my_diary?
    return current_user&.username == params[:username]
  end

  def is_first_tab_active?
    return request.path == ('/diaries' || '/')
  end
end
