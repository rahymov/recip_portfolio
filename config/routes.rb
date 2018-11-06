Rails.application.routes.draw do
  root "recipes#index"
  resolve("ActiveStorage::Variant") { |variant, options| main_app.route_for(:rails_variant, variant, options) }
  devise_for :users
  resources :recipes
end
