require 'rails_helper'

RSpec.describe 'Logging in' do
  it "can log in with valid credentials" do
    visit '/register'

    fill_in 'Name', with: 'Tim Cook'
    fill_in 'Email', with: 'timcook@apple.com'
    fill_in 'Password', with: 'password1'
    fill_in 'Password confirmation', with: 'password1'
    click_button 'Register'

    expect(current_path).to eq("/users/#{User.last.id}")

    # user = User.create(name: "funbucket13", password: "test12345", password_confirmation: "test12345")

    visit root_path

    click_on "Login"

    expect(current_path).to eq(login_path)

    fill_in 'Name', with: 'Tim Cook'
    fill_in 'Password', with: 'password1'

    click_on "Login"

    expect(current_path).to eq(root_path)

    expect(page).to have_content("Welcome, Tim Cook!")
  end

  it "errors with a wrong password" do
    visit '/register'

    fill_in 'Name', with: 'Tim Cook'
    fill_in 'Email', with: 'timcook@apple.com'
    fill_in 'Password', with: 'password1'
    fill_in 'Password confirmation', with: 'password1'
    click_button 'Register'

    expect(current_path).to eq("/users/#{User.last.id}")

    # user = User.create(name: "funbucket13", password: "test12345", password_confirmation: "test12345")

    visit root_path

    click_on "Login"

    expect(current_path).to eq(login_path)

    fill_in 'Name', with: 'Tim Cook'
    fill_in 'Password', with: 'password time'

    click_on "Login"

    expect(current_path).to eq(login_path)

    expect(page).to have_content("Wrong credentials")
  end
end
