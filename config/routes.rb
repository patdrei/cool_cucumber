Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  get "/dashboard", to: "pages#dashboard", as: 'dashboard'

  resources :meal_plans, only: [:new, :create, :edit, :update, :destroy] do
    resources :shopping_list_items, only: [:index, :update]
    resources :meals, only: [:create]
  end

  resources :recipes, only: [:show]
  resources :meals, only: [:destroy]

  get "/preferences", to: "preferences#overview", as: "overview"
  patch "/preferences/:id/deactivate", to: "preferences#deactivate", as: "preference_deactivate"

  post "ingredients/:ingredient_id/preferences", to: "preferences#create_with_ingredient", as: "preference_ingredient"

  post "tags/:tag_id/preferences", to: "preferences#create_with_tag", as: "preference_tag"
  post "meals/:id/shuffle", to: "meals#shuffle", as: "shuffle"

  post "shopping_list_items/:id/change_purchased", to: "shopping_list_items#change_purchased", as: "change_purchased"

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
