Rails.application.routes.draw do
  root "movies#index"
  get "movies/filter/:filter" => "movies#index", as: :filtered_movies
  get "signup" => "users#new"
  get "signin" => "sessions#new"
  resources :genres
  resource :session, only: [:new, :create, :destroy]
  resources :users
  resources :movies do
    resources :reviews 
    resources :favorites, only: [:create, :destroy]
  end
end
