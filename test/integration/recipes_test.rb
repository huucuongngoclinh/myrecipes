require 'test_helper'

class RecipesTest < ActionDispatch::IntegrationTest
  
	def setup
		@chef = Chef.create!(chefname: "VuVT 01", email: "vuvt_01@gmail.com")
		@recipe = Recipe.create!(name: "vegetables saute", description: "good vegetables saute, add oil", chef: @chef)
		@recipe2 = @chef.recipes.build(name: "chicken saute", description: "really good chicken saute")
		@recipe2.save
	end

  test "should get recipes index" do 
  	get recipes_url

  	assert_response :success
  end

  test "should get a list of recipes" do 
  	get recipes_url

  	assert_template 'recipes/index'
  	assert_match @recipe.name, response.body
  	assert_match @recipe2.name, response.body
  end
end
