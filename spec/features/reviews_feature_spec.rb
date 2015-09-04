require 'rails_helper'

feature 'reviewing' do
  before {Restaurant.create name: 'KFC'}

  scenario 'allows users to leave a review using a form' do
    sign_up
    visit '/restaurants'
    click_link "Review KFC"
    fill_in 'Thoughts', with: 'So so'
    select '3', from: 'Rating'
    click_button 'Leave Review'
    expect(current_path).to eq '/restaurants'
    expect(page).to have_content('So so')
  end


  scenario "doesn't allow users to leave a review when not signed in" do
    visit '/restaurants'
    click_link "Review KFC"
    fill_in 'Thoughts', with: 'So so'
    select '3', from: 'Rating'
    click_button 'Leave Review'
    expect(current_path).to eq '/restaurants'
    expect(page).to have_content('User must be signed in to review')
  end
end
