require 'rails_helper'

RSpec.describe 'Viewing Party Create Page' do
  before :each do
    @movie = MovieFacade.all_movies.first
    @user = create(:user)

    visit "/users/#{@user.id}/movies/#{@movie.db_id}/viewing-party/new"
  end

  it 'displays the movie name', :vcr do
    expect(page).to have_content(@movie.title)
  end

  it 'displays duration', :vcr do
    page.first(:css, "#duration")[:value].should eq("#{@movie.runtime}")
  end


  it 'can select a date', :vcr do
    date = Time.now
    date = date.strftime('%Y-%m-%d')
    page.first(:css, "#select_date")[:value].should eq(date)
  end

  it 'displays a start time field', :vcr do
    # page.first(:css, "#start_time")[:value].should eq(Time.now)
    expect(page).to have_content("Start time:")
  end

  it 'displays all users with checkboxes', :vcr do
    users = User.all

    users.each do |user|
      name = user.name.first.upcase
      expect(page).to have_content(name)
    end
  end
end
