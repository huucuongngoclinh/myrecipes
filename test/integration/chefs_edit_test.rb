require 'test_helper'

class ChefsEditTest < ActionDispatch::IntegrationTest

	def setup
		@chef = Chef.create!(chefname: "VuVT 01", email: "truongvukhmt0@gmail.com", password: "password", password_confirmation: "password")
		@chef2 = Chef.create!(chefname: "Vu Vo 02", email: "vuvo02@gmail.com", password: "password", password_confirmation: "password")
		@admin_user = Chef.create!(chefname: "Vu Vo 03", email: "vuvo03@gmail.com", password: "password", password_confirmation: "password", admin: true)
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

	test "accept valid edit" do 
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

	test "accept edit attempt by admin user" do 
		sign_in_as(@admin_user, "password")
		get edit_chef_path(@chef)
		assert_template "chefs/edit"
		patch chef_path(@chef), params: {chef: {chefname: "name edited 2", email: "email_edited_2@example.com"}}	
		assert_redirected_to @chef
		assert_not flash.empty?
		@chef.reload
		assert_match "name edited 2", @chef.chefname
		assert_match "email_edited_2@example.com", @chef.email
	end

	test "redirect edit attempt by non-admin user" do 
		sign_in_as(@chef2, "password")
		patch chef_path(@chef), params: {chef: {chefname: "name edited 2", email: "email_edited_2@example.com"}}	
		assert_redirected_to chefs_path
		assert_not flash.empty?
		@chef.reload
		assert_match "Vu Vo 02", @chef2.chefname
		assert_match "vuvo02@gmail.com", @chef2.email
	end

end








