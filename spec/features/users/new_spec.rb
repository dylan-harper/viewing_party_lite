require 'rails_helper'

RSpec.describe 'Register User Page' do
  xit 'should have a form to create a new user' do
    visit '/register'

    fill_in :name, with: 'Tim Cook'
    fill_in :email, with: 'timcook@apple.com'
    click_button 'Register'

    expect(current_path).to eq("/users/#{User.last.id}")
  end
end
