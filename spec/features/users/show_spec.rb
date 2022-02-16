require 'rails_helper'

RSpec.describe 'the user show page' do

  before :each do
    @user_1 = create(:user)
    @user_2 = create(:user)
    @user_3 = create(:user)
    @user_4 = create(:user)

    @movie1 = MovieFacade.all_movies.first
    @movie2 = MovieFacade.all_movies.second
    @movie3 = MovieFacade.all_movies.third
    @movie4 = MovieFacade.all_movies.fourth

    @party_1 = create(:party, movie_id: @movie1.db_id)
    @party_2 = create(:party, movie_id: @movie1.db_id)
    @party_3 = create(:party, movie_id: @movie2.db_id)
    @party_4 = create(:party, movie_id: @movie3.db_id)

    @user_party_1 = create(:user_party, user_id: @user_1.id, party_id: @party_1.id, status: "Host")
    @user_party_2 = create(:user_party, user_id: @user_1.id, party_id: @party_2.id)
    @user_party_3 = create(:user_party, user_id: @user_1.id, party_id: @party_3.id)
    @user_party_4 = create(:user_party, user_id: @user_2.id, party_id: @party_1.id)
    @user_party_5 = create(:user_party, user_id: @user_2.id, party_id: @party_2.id, status: "Host")
    @user_party_6 = create(:user_party, user_id: @user_2.id, party_id: @party_4.id)
    @user_party_7 = create(:user_party, user_id: @user_3.id, party_id: @party_1.id)
    @user_party_8 = create(:user_party, user_id: @user_3.id, party_id: @party_3.id, status: "Host")
    @user_party_9 = create(:user_party, user_id: @user_3.id, party_id: @party_4.id)
    @user_party_10 = create(:user_party, user_id: @user_4.id, party_id: @party_2.id)
    @user_party_11 = create(:user_party, user_id: @user_4.id, party_id: @party_3.id)
    @user_party_12 = create(:user_party, user_id: @user_4.id, party_id: @party_4.id, status: "Host")

    visit "/users/#{@user_1.id}"
  end

  it 'can visit the correct show page', :vcr do
    expect(current_path).to eq("/users/#{@user_1.id}")
  end

  it 'can display the user info', :vcr do
    expect(page).to have_content(@user_1.name)
    expect(page).to have_content(@user_1.email)
  end

  it 'has discover movie button', :vcr do
    click_button "Discover Movies"

    expect(current_path).to eq("/users/#{@user_1.id}/discover")
  end

  it 'has the event details for each party', :vcr do
    within('#invited-parties') do
      within("#party-#{@party_2.id}") do
        expect(page).to have_content(@movie1.title)
        expect(page).to have_content(@party_2.date)
        expect(page).to have_content(@party_2.start_time)
        expect(page).to have_content("Party Host: #{@user_2.name}")

        expect(page).to have_content("Attendee: #{@user_1.name}")
        expect(page).to have_content("Attendee: #{@user_4.name}")
      end

      within("#party-#{@party_3.id}") do
        expect(page).to have_content(@movie2.title)
        expect(page).to have_content(@party_3.date)
        expect(page).to have_content(@party_3.start_time)
        expect(page).to have_content("Party Host: #{@user_3.name}")

        expect(page).to have_content("Attendee: #{@user_1.name}")
        expect(page).to have_content("Attendee: #{@user_4.name}")
      end
    end
  end

  it 'has a movie title for each party that is a link', :vcr do
    within('#invited-parties') do
      within("#party-#{@party_2.id}") do
        click_link "#{@movie1.title}"
      end
    end
    expect(current_path).to eq("/users/#{@user_1.id}/movies/#{@movie1.db_id}")
  end

  it 'has a section with parties that the user has created', :vcr do
    within('#created-parties') do
      within("#party-#{@party_1.id}") do
        expect(page).to have_content(@movie1.title)
        expect(page).to have_content(@party_1.date)
        expect(page).to have_content(@party_1.start_time)
        expect(page).to have_content("Party Host: #{@user_1.name}")

        expect(page).to have_content("Attendee: #{@user_2.name}")
        expect(page).to have_content("Attendee: #{@user_3.name}")
      end
    end
  end
end
