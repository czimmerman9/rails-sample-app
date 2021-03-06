require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  
	test "invalid signup information" do
	  assert_no_difference 'User.count' do
	  	get signup_path
	  	post users_path, user: { name: "", email: "user@invalid", password: "foo", password_confirmation: "bar" }
	  end
	  assert_template 'users/new'
	  assert_select "div#error_explanation"
	  assert_select "div.alert"
	end

	test "valid signup information" do
		assert_difference 'User.count', 1 do
			get signup_path
			post_via_redirect users_path, user: { name: "Testing", email: "test@email.com", password: "123456", password_confirmation: "123456" }
		end
		assert_template 'users/show'
		assert is_logged_in?
		assert_not flash.empty?
	end
end
