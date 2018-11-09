Rails.application.routes.draw do

  root "recipes#index"
  post '/rate' => 'rater#create', :as => 'rate'
  resolve("ActiveStorage::Variant") { |variant, options| main_app.route_for(:rails_variant, variant, options) }
  devise_for :users

  resources :recipes, only: [:show] do
    resources :reviews, only: [:new, :index, :show, :edit]
  end
  resources :recipes
  get '/categories/:id/recipes', to: "categories#index", as: "/category_recipes"
  # resources :categories, only: :show do
  #   resources :recipes, only: [:index, :show]
  # end
end
