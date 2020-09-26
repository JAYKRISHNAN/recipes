class RecipesController < ApplicationController
  def index
    @recipes = get_all_recipes
  end

  def show
    @recipe = get_recipe
  end

  private

  def get_all_recipes
    $contentful.entries(content_type: 'recipe')
  end

  def get_recipe
    $contentful.entry(params[:id])
  end
end