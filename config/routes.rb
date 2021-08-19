Rails.application.routes.draw do
  namespace :api do
    get 'videos/search'
  end
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :videos
  namespace :api, defaults: {format: :json} do
    get 'videos/:id/search', to: 'videos#search'
  end
end
