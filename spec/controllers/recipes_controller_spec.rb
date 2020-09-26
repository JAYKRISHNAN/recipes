require 'rails_helper'


describe RecipesController, type: :controller do
  render_views

  describe 'GET index' do
    let(:recipes) do
      [
        OpenStruct.new({title: 'Recipe Name 1', id: 'recipe_id_1', photo: OpenStruct.new({image_url: 'recipe_1_image_url'})}),
        OpenStruct.new({title: 'Recipe Name 2', id: 'recipe_id_2', photo: OpenStruct.new({image_url: 'recipe_2_image_url'})})
      ]
    end

    let (:make_request) { get :index }

    before do
      allow($contentful).to receive(:entries).with({content_type: 'recipe'}) { recipes }
    end

    it 'fetches the entries from contentful of content type recipes' do
      expect($contentful).to receive(:entries).with({content_type: 'recipe'}) { recipes }

      make_request
    end

    it 'displays title and image of all recipes' do
      make_request

      expect(response).to have_http_status(:success)
      response_body = response.body
      expect(response_body).to include recipes.first.title
      expect(response_body).to include recipes.last.title
      expect(response_body).to include recipes.first.photo.image_url
      expect(response_body).to include recipes.last.photo.image_url
    end
  end

  describe 'GET show' do
    let(:recipe) do
      OpenStruct.new({
          title: 'Recipe Name 1',
          id: 'random_recipe_id',
          photo: OpenStruct.new({image_url: 'recipe_1_image_url'}),
          description: "Recipe 1 description",
          calories: 788,
          tags: [OpenStruct.new({name: 'tag_1'}), OpenStruct.new({name: 'tag_2'})]
      })
    end

    let (:make_request) { get :show, params: { id: 'random_recipe_id' } }

    before do
      allow($contentful).to receive(:entry).with('random_recipe_id') { recipe }
    end

    it 'fetches the recipe entry from contentful' do
      expect($contentful).to receive(:entry).with('random_recipe_id') { recipe }

      make_request
    end

    it 'displays title and image of all recipes' do
      make_request

      expect(response).to have_http_status(:success)
      response_body = response.body
      expect(response_body).to include recipe.title
      expect(response_body).to include recipe.photo.image_url
      expect(response_body).to include recipe.calories.to_s
      expect(response_body).to include recipe.description
      expect(response_body).to include 'tag_1'
      expect(response_body).to include 'tag_2'
    end
  end
end
