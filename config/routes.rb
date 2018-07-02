Rails.application.routes.draw do
  devise_for :users
  resources :restaurants, only: [:index, :show]
  resources :categories, only: :show
  root "restaurants#index" 

  namespace :admin do
    resources :restaurants
    resources :categories
    root "restaurants#index"
  end


 # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
