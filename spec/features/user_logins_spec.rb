require 'rails_helper'

RSpec.feature "User Login page", type: :feature, js: true do

  before :each do
    User.find_or_create_by(email: 'jane@example.com') do |user|
      user.first_name = 'Jane'
      user.last_name = 'Doe'
      user.password = '12345'
      user.password_confirmation = '12345'
    end
  end

  scenario "Visitor can login sucessfully" do
    # ACT
    visit root_path
    click_on('Login')

    expect(page).to have_button 'Save changes'

    within 'h1' do
      expect(page).to have_content 'Login'
    end

    fill_in 'email', with: 'jane@example.com'
    fill_in 'password', with: '12345'
    click_button('Save changes', exact: true)

    expect(page).to have_css '.products-index'

    within '.navbar-right' do
      expect(page).to have_content 'Logout'
    end
  end
end
