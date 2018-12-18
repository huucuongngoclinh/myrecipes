require 'test_helper'

class ChefTest < ActiveSupport::TestCase

	def setup
		@chef = Chef.new(chefname: "John", email: "john@example.com", password: "password", password_confirmation: "password")
	end

	test "should be valide" do 
		assert @chef.valid?
	end

	test "name should be presence" do 
		@chef.chefname = " "
		assert_not @chef.valid?
	end

	test "email should be presence" do 
		@chef.email = " "
		assert_not @chef.valid?
	end

	test "name should be less than 30 characters" do 
		@chef.chefname = "a" * 31
		assert_not @chef.valid?
	end

	test "email should be less than 255 characters" do 
		@chef.email = "a" * 255 + "@gmail.com"
		assert_not @chef.valid?
	end

	test "email should accept correct format" do 
		valid_emails = %w[
			abc@gmail.com john@example.com smith+marisa@yahoo.com
		]
		valid_emails.each do |valid|
			@chef.email = valid
			assert @chef.valid? , "#{valid.inspect} should be valid"
		end
	end

	test "should reject invalid email" do 
		invalid_email = %w[
			abc@gmail dan@example,com marisa@bar+foo.com
		]
		invalid_email.each do |invalid|
			@chef.email = invalid
			assert_not @chef.valid?, "#{invalid.inspect}"
		end
	end

	test "email should be uniqueness and case insensitive" do 
		duplicate_chef = @chef.dup
		duplicate_chef.email = @chef.email.upcase
		@chef.save
		assert_not duplicate_chef.valid?
	end

	test "email should be lowercase before hitting the db" do 
		mix_email = "JonN@EXAMPLE.com"
		@chef.email = mix_email
		@chef.save
		assert_equal mix_email.downcase, @chef.reload.email
	end

	test "password should be presence" do 
		@chef.password = @chef.password_confirmation = " "
		assert_not @chef.valid?
	end
end





















