Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  get "/dashboard", to: "pages#dashboard", as: 'dashboard'

  resources :meal_plans, only: [:new, :create, :edit, :update, :destroy] do
    resources :shopping_list_items, only: [:index, :update]
    resources :meals, only: [:index]
  end

  resources :recipes, only: [:show]

  get "/preferences", to: "preferences#overview", as: "overview"
  post "/preferences", to: "preferences#preference_set", as: "preference_set"

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
