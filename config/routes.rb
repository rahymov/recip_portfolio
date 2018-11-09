Rails.application.routes.draw do
  get 'reviews/new'
  get 'reviews/edit'
  root "recipes#index"
  resolve("ActiveStorage::Variant") { |variant, options| main_app.route_for(:rails_variant, variant, options) }
  devise_for :users

  resources :recipes
  get '/categories/:id/recipes', to: "categories#index", as: "/category_recipes"
  # resources :categories, only: :show do
  #   resources :recipes, only: [:index, :show]
  # end
end
