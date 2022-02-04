# frozen_string_literal: true

module ApplicationHelper
  def my_diaries_index?
    return true if current_user&.username == params[:username] || !params[:username]
  end

  def my_diary?
    return true if current_user&.username == params[:username]
  end
end
