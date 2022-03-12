# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do
    authenticated :user do
      root to: 'home#index', as: :authenticated_root
    end
  end

  root to: 'welcome#index'

  namespace :api do
    resources :games, only: %i[index]
    resources :scores, only: %i[index]
    resources :diaries, only: %i[show]
  end

  get '/diaries', to: 'home#index', as: 'latest_diaries'
  scope ':username' do
    resources :diaries
  end
end
