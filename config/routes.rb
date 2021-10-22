Rails.application.routes.draw do
  root to: 'diaries#index'
  resources :diaries
  resources :games, only: %i[index show create] # あとで修正
end
