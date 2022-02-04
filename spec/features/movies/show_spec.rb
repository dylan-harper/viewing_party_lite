require 'rails_helper'

RSpec.describe 'Movie Details page' do
  before :each do
    @movie = MovieFacade.all_movies.first
    @user = create(:user)
  end

  it 'has a button to create a viewing party that takes the user to the new viewing party page', :vcr do
    visit "/users/#{@user.id}/movies/#{@movie.db_id}"
    click_button "Create a Viewing Party"
    expect(current_path).to eq("/users/#{@user.id}/movies/#{@movie.db_id}/viewing-party/new")
  end

  it 'has a button to return to the discover page', :vcr do
    visit "/users/#{@user.id}/movies/#{@movie.db_id}"
    click_button "Return to Discover Page"
    expect(current_path).to eq("/users/#{@user.id}/discover")
  end

  it 'displays the movie title', :vcr do
    visit "/users/#{@user.id}/movies/#{@movie.db_id}"

    expect(page).to have_content("Movie Title: #{@movie.title}")
  end

  it 'displays the vote average of the movie', :vcr do
    visit "/users/#{@user.id}/movies/#{@movie.db_id}"
    expect(page).to have_content("Vote Average: #{@movie.vote_average}")
  end

  it 'displays the runtime in hours and minutes', :vcr do
    visit "/users/#{@user.id}/movies/#{@movie.db_id}"
    expect(page).to have_content("Runtime: #{@movie.runtime}")
  end

  it 'displays the genres associated with the movie', :vcr do
    visit "/users/#{@user.id}/movies/#{@movie.db_id}"

    within("#genres") do
      expect(page).to have_content(@movie.genre_ids[0])
      expect(page).to have_content(@movie.genre_ids[1])
      expect(page).to have_content("Drama")
      expect(page).to have_content("Romance")
    end
  end

  it 'displays the movie summary', :vcr do
    visit "/users/#{@user.id}/movies/#{@movie.db_id}"

    expect(page).to have_content(@movie.overview)
  end
end
