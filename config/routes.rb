Rails.application.routes.draw do
  namespace :api do
    get 'videos/search'
  end
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :videos
  resources :lists
  namespace :api, defaults: {format: :json} do
    get 'videos/:id/search', to: 'videos#search'
  end
  get 'videos/:id/text_search', to: 'videos#text_search', as: :text_search

end
