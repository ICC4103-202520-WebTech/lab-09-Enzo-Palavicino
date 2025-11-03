class RecipesController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :set_recipe, only: %i[show edit update destroy]

  def index
    @recipes = policy_scope(Recipe).includes(:user).order(created_at: :desc)
  end

  def show; end

  def new
    @recipe = current_user.recipes.build
    authorize @recipe
  end

  def edit
    authorize @recipe
  end

  def create
    @recipe = current_user.recipes.build(recipe_params)
    authorize @recipe

    if @recipe.save
      redirect_to @recipe, notice: "Recipe was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    authorize @recipe

    if @recipe.update(recipe_params)
      redirect_to @recipe, notice: "Recipe was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @recipe
    @recipe.destroy
    redirect_to recipes_path, status: :see_other, notice: "Recipe was successfully deleted."
  end

  private

  def set_recipe
    @recipe = Recipe.find(params[:id])
  end

  def recipe_params
    params.require(:recipe).permit(:title, :cook_time, :difficulty, :instructions)
  end
end
