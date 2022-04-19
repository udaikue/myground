# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do
    authenticated :user do
      root to: 'diaries#index', as: :authenticated_root
    end
  end

  root to: 'welcome#index'
  get '/pp', to: 'home#pp', as: 'pp'
  get '/tos', to: 'home#tos', as: 'tos'

  namespace :api do
    resources :games, only: %i[index]
    resources :scores, only: %i[index]
    resources :diaries, only: %i[show]
  end

  scope ':username' do
    resources :diaries
  end
end
