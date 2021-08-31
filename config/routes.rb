Rails.application.routes.draw do
  get 'errors/not_found'
  get 'errors/internal_server_error'
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
  get 'videos/:id/text_search', to: 'videos#text_search', as: :text_search
  match "/404", to: "errors#not_found", via: :all
  match "/500", to: "errors#internal_server_error", via: :all
end
