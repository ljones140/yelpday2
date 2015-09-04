
def sign_up_and_create_restaurant
  visit '/'
  click_link "Sign up"
  fill_in('Email', with:'new_restaurant_maker@test.com')
  fill_in('Password', with:'testtest')
  fill_in('Password confirmation', with:'testtest')
  click_button('Sign up')
  click_link "Add a restaurant"
  fill_in 'Name', with: "SFC"
  click_button 'Create Restaurant'
  # click_link "Sign out"
end
