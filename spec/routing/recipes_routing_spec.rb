require 'rails_helper'


describe 'Recipes Routing', type: :routing do
  it 'routes root path to index action of recipes' do
    expect(get: '/').to route_to(controller: 'recipes', action: 'index')
  end

  it 'has route defined for recipes index action' do
    expect(get: '/recipes').to route_to(controller: 'recipes', action: 'index')
  end

  it 'has route defined for individual recipe show page' do
    expect(get: '/recipes/1').to route_to(controller: 'recipes', action: 'show', id: '1')
  end
end

