require 'test_helper'

class RecipesTest < ActionDispatch::IntegrationTest
  
	def setup
		@chef = Chef.create!(chefname: "VuVT 01", email: "truongvukhmt0@gmail.com")
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
  	assert_select "a[href=?]", recipe_path(@recipe), text: @recipe.name
  	assert_select "a[href=?]", recipe_path(@recipe2), text: @recipe2.name 
  end

  test "should get recipe show" do 
  	get recipe_path(@recipe)
  	assert_template 'recipes/show'
  	assert_match @recipe.name, response.body
  	assert_match @recipe.description, response.body
  	assert_match @chef.chefname, response.body
  end

  test "create a valid recipe" do 
    get new_recipe_path
    assert_template "recipes/new"
    name_of_recipe = "chicken chicken saute"
    description_of_recipe = "This is a chicken saute, really good"
    assert_difference "Recipe.count" , 1 do 
      post recipes_path, params: {recipe: {name: name_of_recipe, description: description_of_recipe}}
    end
    follow_redirect!
    assert_match name_of_recipe.capitalize, response.body
    assert_match description_of_recipe, response.body
  end

  test "reject invalid recipe summittion" do 
    get new_recipe_path
    assert_template "recipes/new"
    assert_no_difference 'Recipe.count' do 
      post recipes_path, params: {recipe: {name: " ", description: ""} }
    end
    assert_template "recipes/new"
    assert_select "h2.panel-title"
    assert_select "div.panel-body"
  end
end












