require 'test_helper'

class RecipeTest < ActiveSupport::TestCase

	def setup
		@chef = Chef.create!(chefname: "Vu 01", email: "vu_01@gmail.com", password: "password", password_confirmation: "password")
		@recipe = @chef.recipes.build(name: "vestable", description: "A good vestable receipe")
	end	

	test "receipe should be valid" do 
		assert @recipe.valid?
	end

	test "name should be presence" do
		@recipe.name = " "
		assert_not @recipe.valid?
	end

	test "description should be presence" do
		@recipe.description = " "
		assert_not @recipe.valid?
	end

	test "description have min length 5" do 
		@recipe.description = "a" * 3
		assert_not @recipe.valid?
	end

	test "description have max length 500" do 
		@recipe.description = "a" * 600
		assert_not @recipe.valid?
	end
end