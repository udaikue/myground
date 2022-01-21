# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  root to: 'diaries#index'

    namespace :api do
      resources :games, only: %i[index]
      resources :diaries, only: %i[show]
    end

    scope ':username' do
      resources :diaries
    end
end
