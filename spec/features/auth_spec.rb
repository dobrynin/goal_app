require 'spec_helper'
require 'rails_helper'

feature "the signup process" do

  scenario "has a new user page" do
    visit new_user_url
    expect(page).to have_content "Sign Up"
  end

  feature "signing up a user" do
    scenario "shows email on the homepage after signup" do
      visit new_user_url
      fill_in 'Email', with: 'testing_email'
      fill_in 'Password', with: 'password'
      click_on 'Submit'

      expect(page).to have_content('testing_email')
    end


  end

end

feature "logging in" do

  scenario "shows email on the homepage after login" do
    @user = User.create!(email: 'testing_email', password: 'password')

    visit new_sessions_url
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password
    click_on 'Submit'

    expect(page).to have_content('testing_email')

  end

end

feature "logging out" do

  scenario "begins with a logged out state" do
    visit new_sessions_url
    expect(page).to have_content('Sign In')
  end

  scenario "doesn't show username on the homepage after logout" do
    
  end

end
