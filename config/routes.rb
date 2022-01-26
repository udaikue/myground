# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do
    unauthenticated :user do
      root to: 'devise/sessions#new', as: :unauthenticated_root
    end
  end

  root to: 'diaries#index', as: :authenticated_root

  namespace :api do
    resources :games, only: %i[index]
    resources :diaries, only: %i[show]
  end

  scope ':username' do
    resources :diaries
  end
end
