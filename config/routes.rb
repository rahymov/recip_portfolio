Rails.application.routes.draw do
  root "recipes#index"
  resolve("ActiveStorage::Variant") { |variant, options| main_app.route_for(:rails_variant, variant, options) }
  devise_for :users
  resources :user do
    resources :recipes, only: [:index, :show]
  end
  resources :recipes
  get '/categories/:id/recipes', to: "categories#show"
  # resources :categories, only: :show do
  #   resources :recipes, only: [:index, :show]
  # end
  # get 'categories/index'
  # get 'categories/show'
  # get '/categories/:id/recipes', to: "recipes#index"
end
