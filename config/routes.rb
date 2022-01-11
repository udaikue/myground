# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'diaries#index'

  namespace :api do
    resources :games, only: %i[index]
  end

  resources :diaries
end
