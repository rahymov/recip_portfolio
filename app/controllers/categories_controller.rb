class CategoriesController < ApplicationController

  def show
    @category = Category.find(params[:id])
    @recipes = @category.recipes
    @categories = Category.all
  end
end
