require 'test_helper'

class ChefsShowTest < ActionDispatch::IntegrationTest

	def setup
		@chef = Chef.create!(chefname: "VuVT 01", email: "truongvukhmt0@gmail.com", password: "password", password_confirmation: "password")
		@recipe = Recipe.create!(name: "vegetables saute", description: "good vegetables saute, add oil", chef: @chef)
		@recipe2 = @chef.recipes.build(name: "chicken saute", description: "really good chicken saute")
		@recipe2.save
	end

	test "should get chef show" do 
		get chef_path(@chef)
		assert_template "chefs/show"
		assert_select "a[href=?]", recipe_path(@recipe), text: @recipe.name
  	assert_select "a[href=?]", recipe_path(@recipe2), text: @recipe2.name 
  	assert_match @recipe.description, response.body
  	assert_match @recipe2.description, response.body
	end

	
end
