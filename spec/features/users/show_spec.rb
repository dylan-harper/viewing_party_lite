require 'rails_helper'

RSpec.describe 'the user show page' do

  before :each do
    # @user = User.create!(name: 'Bob', email: 'bob.bob@bob.com')
    @user_1 = create(:user)
    @user_2 = create(:user)
    @user_3 = create(:user)
    @user_4 = create(:user)

    @movie1 = Movie.create!(name: 'Braveheart', runtime: '180', genre: 'fun', image_url: 'fff', summary: 'violent')
    @movie2 = Movie.create!(name: 'lonelyheart', runtime: '120', genre: 'bad', image_url: 'ddd', summary: 'easy')
    @movie3 = Movie.create!(name: 'dim sum', runtime: '30', genre: 'okay', image_url: 'bbb', summary: 'medium')
    @movie4 = Movie.create!(name: 'racecar', runtime: '2', genre: 'mouse', image_url: 'lll', summary: 'hard')

    @party_1 = Party.create!(duration: 100, date: '1/2/22', start_time: '06:37pm', movie_id: @movie1.id)
    @party_2 = Party.create!(duration: 50, date: '2/2/22', start_time: '06:37am', movie_id: @movie1.id)
    @party_3 = Party.create!(duration: 10, date: '3/2/22', start_time: '02:37pm', movie_id: @movie2.id)
    @party_4 = Party.create!(duration: 1000, date: '4/2/22', start_time: '00:37am', movie_id: @movie3.id)
    # @party_2 = Party.create!(:party)
    # @party_3 = Party.create!(:party)
    # @party_4 = Party.create!(:party)
    #
    @user_party_1 = UserParty.create!(user_id: @user_1.id, party_id: @party_1.id, status: "Invited")
    @user_party_2 = UserParty.create!(user_id: @user_1.id, party_id: @party_2.id, status: "Invited")
    @user_party_3 = UserParty.create!(user_id: @user_1.id, party_id: @party_3.id, status: "Invited")
    @user_party_4 = UserParty.create!(user_id: @user_1.id, party_id: @party_4.id, status: "Host")
    @user_party_5 = UserParty.create!(user_id: @user_2.id, party_id: @party_1.id, status: "Invited")
    @user_party_6 = UserParty.create!(user_id: @user_3.id, party_id: @party_1.id, status: "Invited")
    @user_party_7 = UserParty.create!(user_id: @user_3.id, party_id: @party_1.id, status: "Invited")
    @user_party_8 = UserParty.create!(user_id: @user_4.id, party_id: @party_1.id, status: "Invited")

    # @movie_1 = create(:movie)
    # @movie_2 = create(:movie)
    # @movie_3 = create(:movie)
    # @movie_4 = create(:movie)
    # @movie_5 = create(:movie)
    # @movie_6 = create(:movie)
    #
    # @party_1 = create(:party, movie: movie_1)
    # @party_2 = create(:party, movie: movie_2)
    # @party_3 = create(:party, movie: movie_3)
    # @party_3 = create(:party, movie: movie_4)
    #
    # @user_party = create(:user_party, user: user_1, party: party_1)
    # @user_party = create(:user_party, user: user_1, party: party_1)
    # @user_party = create(:user_party, user: user_3, party: party_3)
    # @user_party = create(:user_party, user: user_3, party: party_3)




    visit "/users/#{@user_1.id}"
  end

  it 'can visit the correct show page' do
    expect(current_path).to eq("/users/#{@user_1.id}")
  end

  it 'can display the user info' do
    expect(page).to have_content(@user_1.name)
    expect(page).to have_content(@user_1.email)
  end

  it 'has discover movie button' do
    click_button "Discover Movies"

    expect(current_path).to eq("/users/#{@user_1.id}/discover")
  end

  it 'lists viewing parties user is invited to' do
    within('#invited-parties') do
      expect(page).to have_content(@party_1.id)
      expect(page).to have_content(@party_2.id)
      expect(page).to have_content(@party_3.id)
    end
  end




end
