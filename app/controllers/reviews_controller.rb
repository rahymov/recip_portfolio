class ReviewsController < ApplicationController
  before_action :set_review, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :set_recipe
  def new
    @review = Review.new
  end
  def create
    @review = Review.new(review_params)
    @review.user_id = current_user.id
    @review.recipe_id = @recipe.id
    if @review.save
      flash[:notice] = 'Review was successfully created.'
      redirect_to @movie
    else
      render :new
    end
  end

  def edit
  end
  def update
    if @review.update(review_params)
      flash[:notice] = 'Review was successfully updated.'
      redirect_to @recipe
    else
      render :edit
    end
  end

  def destroy
    @review.destroy
    flash[:notice] = "Review was successfully deleted."
    redirect_to recipes_url
  end

  private
    def set_params
      @review = Review.find(params[:id])
    end
    def set_recipe
      @recipe = Recipe.find(params[:id])
    end
    def review_params
      params.require(:review).permit(:rating, :comment)
    end
end
