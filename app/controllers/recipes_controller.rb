class RecipesController < ApplicationController
  before_action :set_params, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user! , except: [:show, :index]
  before_action :require_user!, only: [:edit, :destroy, :update]
  def index
    @recipes = Recipe.all.order_by_desc # implemented query method
    @categories = Category.all
    # @category = Category.find(params[:id])
  end

  def new
    @recipe = current_user.recipes.build

  end

  def create
    if current_user
      @recipe = current_user.recipes.build(recipe_params)
  		if @recipe.save
        flash[:success] = "Successfully created."
  			redirect_to @recipe
  		else
  			render 'new'
      end
    end
  end

  def show
  end

  def edit
  end

  def update
    if current_user
      if @recipe.update(recipe_params)
        flash[:success] = "Successfully updated."
  			redirect_to @recipe
  		else
  			render 'edit'
  		end
    end
  end
  def destroy
    @recipe.destroy
    redirect_to root_path, notice: "Successfully deleted recipe"
  end

  def require_user!
    if current_user != Recipe.find(params[:id]).user
      flash[:error] = "Sorry you not authorized!"
      redirect_to root_path
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
