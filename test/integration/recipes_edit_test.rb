require 'test_helper'

class RecipesEditTest < ActionDispatch::IntegrationTest

	def setup
		@chef = Chef.create!(chefname: "VuVT 01", email: "truongvukhmt0@gmail.com")
		@recipe = Recipe.create!(name: "vegetables saute", description: "good vegetables saute, add oil", chef: @chef)
	end

	test "reject invalid recipe update" do 
		get edit_recipe_path(@recipe)
		assert_template "recipes/edit"
		patch recipe_path(@recipe), params: {recipe: {name: " ", description: "some desc"}}
		assert_template "recipes/edit"
		assert_select "h2.panel-title"
		assert_select "div.panel-body"
	end

	test "success update a recipe" do 
		get edit_recipe_path(@recipe)
		assert_template "recipes/edit"
		update_name = "Test update name"
		update_description = "Test update description"
		patch recipe_path(@recipe), params: {recipe: {name: update_name, description: update_description}}
		assert_redirected_to @recipe
		assert_not flash.empty?
		@recipe.reload
		assert_match update_name, @recipe.name
		assert_match update_description, @recipe.description		
	end
end
