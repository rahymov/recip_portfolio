class RecipesController < ApplicationController
  before_action :set_params, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user! , except: [:show, :index]
  def index
    @recipes = Recipe.all
  end

  def new
    @recipe = current_user.recipes.build

  end

  def create
    if current_user
      @recipe = current_user.recipes.build(recipe_params)
  		if @recipe.save
  			redirect_to @recipe
  		else
  			render 'new'
      end
    end
  end

  def show
    @categories = Category.all
  end

  def edit
  end

  def update
    if current_user
      if @recipe.update(recipe_params)
  			redirect_to @recipe
  		else
  			render 'edit'
  		end
    end
  end
  def destroy
    if current_user
      @recipe.destroy
      redirect_to root_path, notice: "Successfully deleted recipe"
    else
      redirect_to recipes_path
    end
  end

  private
    def set_params
      @recipe = Recipe.find(params[:id])
    end
    def recipe_params
      params.require(:recipe).permit(:title, :description, :user_id, :image, category_ids: [] )
    end
end
