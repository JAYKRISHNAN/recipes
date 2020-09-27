class RecipesController < ApplicationController
  def index
    @recipes = get_all_recipes
  end

  def show
    @recipe = get_recipe
    @tag_names = tag_names
    @chef_name = chef_name
  end

  private

  def get_all_recipes
    $contentful.entries(content_type: 'recipe')
  end

  def get_recipe
    $contentful.entry(params[:id])
  end

  def chef_name
    chef_details_available? ? @recipe.chef.name : 'N/A'
  end

  def tag_names
    tags_details_available? ? @recipe.tags.map(&:name).map(&:titleize).join(', ') : 'N/A'
  end

  def chef_details_available?
    @recipe.respond_to?(:chef)
  end

  def tags_details_available?
    @recipe.respond_to?(:tags)
  end
end