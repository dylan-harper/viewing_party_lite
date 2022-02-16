require 'rails_helper'

RSpec.describe 'Register User Page' do
  it 'should have a form to create a new user' do
    visit '/register'

    fill_in 'Name', with: 'Tim Cook'
    fill_in 'Email', with: 'timcook@apple.com'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'
    click_button 'Register'

    expect(current_path).to eq("/users/#{User.last.id}")
    expect(User.last.password_digest).to be_a String
    expect(page).to have_content('Welcome, Tim Cook')

  end

  it 'new user sad path' do
    visit '/register'

    fill_in 'Name', with: 'Tim Cook'
    fill_in 'Email', with: 'timcook@apple.com'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'wrong password'
    click_button 'Register'

    expect(current_path).to eq('/register')
  end
end
