Rails.application.routes.draw do
  root to: 'diaries#index'
  resources :diaries
end
