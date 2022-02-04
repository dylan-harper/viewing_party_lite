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
    # visit "/users/#{@user.id}/movies/#{@movie.db_id}/viewing-party/new"
    page.first(:css, "#duration")[:value].should eq("#{@movie.runtime}")
    # expect(page).to have_content("Duration: #{@movie.runtime}")
  end


  xit '' do

  end

  xit '' do

  end

  xit '' do

  end
end
