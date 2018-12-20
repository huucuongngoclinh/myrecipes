require 'test_helper'

class ChefsEditTest < ActionDispatch::IntegrationTest

	def setup
		@chef = Chef.create!(chefname: "VuVT 01", email: "truongvukhmt0@gmail.com", password: "password", password_confirmation: "password")
	end

	test "reject an invalid edit profile" do 
		sign_in_as(@chef, "password")
		get edit_chef_path(@chef)
		assert_template "chefs/edit"
		patch chef_path, params: {chef: {chefname: " ", email: " "}}
		assert_template "chefs/edit"
		assert_select "h2.panel-title"
		assert_select "div.panel-body"
	end

	test "accept valid signup" do 
		sign_in_as(@chef, "password")
		get edit_chef_path(@chef)
		assert_template "chefs/edit"
		patch chef_path, params: {chef: {chefname: "name edited", email: "email_edited@example.com"}}	
		assert_redirected_to @chef
		assert_not flash.empty?
		@chef.reload
		assert_match "name edited", @chef.chefname
		assert_match "email_edited@example.com", @chef.email
	end
end
