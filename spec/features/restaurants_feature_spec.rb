require 'rails_helper'

feature 'restaurants' do
  context 'no restaurants have been added' do
    scenario 'should display a prompt to add a restaurant' do
      visit '/restaurants'
      expect(page).to have_content 'No restaurants yet'
      expect(page).to have_link 'Add a restaurant'
    end
  end

  context 'restaurants have been added' do
    before do
      Restaurant.create(name: 'KFC')
    end

    scenario 'display restaurants' do
      visit '/restaurants'
      expect(page).to have_content('KFC')
      expect(page).not_to have_content('No restaurants yet')
    end
  end

  context 'creating restaurants' do

    scenario 'prompts user to fill out a form, then displays the new restaurant' do
      sign_up
      visit '/restaurants'
      click_link 'Add a restaurant'
      fill_in 'Name', with: 'Siv\'s Place'
      click_button 'Create Restaurant'
      expect(page).to have_content 'Siv\'s Place'
      expect(current_path).to eq '/restaurants'
    end

    context 'user not logged in' do
      it 'does not allow restaurant to be created' do
        visit '/restaurants'
        click_link 'Add a restaurant'
        expect(page).to have_content 'You need to sign in or sign up before continuing.'
      end
    end


    context 'an invalid restaurant' do
      it 'does not let you submit a name that is too short' do
        sign_up
        visit '/restaurants'
        click_link 'Add a restaurant'
        fill_in 'Name', with: 'kf'
        click_button 'Create Restaurant'
        expect(page).not_to have_css 'h2', text: 'kf'
        expect(page).to have_content 'error'
      end
    end

  end

  context 'viewing restaurants' do

    let!(:kfc){Restaurant.create(name:'KFC')}

    scenario 'lets a user view a restaurant' do
      visit '/restaurants'
      click_link 'KFC'
      expect(page).to have_content 'KFC'
      expect(current_path).to eq "/restaurants/#{kfc.id}"
    end
  end

  context 'editing restaurants' do

    before { sign_up_and_create_restaurant }

    scenario 'let a user edit a restaurant' do
      visit '/restaurants'
      click_link 'Edit SFC'
      fill_in 'Name', with: "Siv's Fried Chicken"
      click_button 'Update Restaurant'
      expect(page).to have_content "Siv's Fried Chicken"
      expect(current_path).to eq '/restaurants'
    end

    scenario 'do not let a user edit a restaurant which they did not create' do
      visit '/restaurants'
      click_link 'Add a restaurant'
      fill_in 'Name', with: "Siv's Place"
      click_button 'Create Restaurant'
      switch_to_new_user
      visit '/restaurants'
      click_link "Edit Siv's Place"
      expect(page).to have_content "You cannae editta that capn - it isnt yours to do so"
      expect(current_path).to eq '/restaurants'
    end
  end

  context 'deleting restaurants' do

    before { sign_up_and_create_restaurant }

    scenario 'removes a restaurant when a user clicks a delete link' do
      visit '/restaurants'
      click_link 'Delete SFC'
      expect(page).not_to have_content 'SFC'
      expect(page).to have_content 'Restaurant deleted successfully'
    end

    scenario 'do not let a user delete a restaurant which they did not create' do
      switch_to_new_user
      visit '/restaurants'
      click_link "Delete SFC"
      expect(page).to have_content "You cannae deltitta that capn - it isnt yours to do so"
      expect(current_path).to eq '/restaurants'
    end

  end

end
