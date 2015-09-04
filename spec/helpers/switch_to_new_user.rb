
def switch_to_new_user
  click_link "Sign out"
  click_link "Sign up"
  fill_in('Email', with:'test_second_user@test.com')
  fill_in('Password', with:'testtest')
  fill_in('Password confirmation', with:'testtest')
  click_button('Sign up')
end
