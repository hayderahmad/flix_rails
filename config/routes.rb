Rails.application.routes.draw do
  root "movies#index"
  get "signup" => "users#new"
  get "signin" => "sessions#new"
  resource :session, only: [:new, :create, :destroy]
  resources :users
  resources :movies do
    resources :reviews 
  end
end
