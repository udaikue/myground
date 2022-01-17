# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'diaries#index'

  namespace :api do
    resources :games, only: %i[index]
    resources :diaries, only: %i[show]
  end

  resources :diaries
end
