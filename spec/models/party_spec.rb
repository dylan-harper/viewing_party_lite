require 'rails_helper'

RSpec.describe Party, type: :model do
  describe 'relationships' do
    it { should have_many :user_parties}
    it { should have_many(:users).through(:user_parties)}
    it { should belong_to :movie}
  end

  before :each do
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
    @user_party_1 = UserParty.create!(user_id: @user_1.id, party_id: @party_1.id, status: "Host")
    @user_party_2 = UserParty.create!(user_id: @user_1.id, party_id: @party_2.id, status: "Invited")
    @user_party_3 = UserParty.create!(user_id: @user_1.id, party_id: @party_3.id, status: "Invited")
    @user_party_4 = UserParty.create!(user_id: @user_2.id, party_id: @party_1.id, status: "Invited")
    @user_party_5 = UserParty.create!(user_id: @user_2.id, party_id: @party_2.id, status: "Host")
    @user_party_6 = UserParty.create!(user_id: @user_2.id, party_id: @party_4.id, status: "Invited")
    @user_party_7 = UserParty.create!(user_id: @user_3.id, party_id: @party_1.id, status: "Invited")
    @user_party_8 = UserParty.create!(user_id: @user_3.id, party_id: @party_3.id, status: "Host")
    @user_party_9 = UserParty.create!(user_id: @user_3.id, party_id: @party_4.id, status: "Invited")
    @user_party_10 = UserParty.create!(user_id: @user_4.id, party_id: @party_2.id, status: "Invited")
    @user_party_11 = UserParty.create!(user_id: @user_4.id, party_id: @party_3.id, status: "Invited")
    @user_party_12 = UserParty.create!(user_id: @user_4.id, party_id: @party_4.id, status: "Host")
  end

  describe '#host' do
    it 'returns the user who is the host of the party' do
      expect(@party_1.host).to eq(@user_1)
    end
  end

  describe '#attendees' do
    it 'returns a list of the invited people of a party, but not the host' do
      expect(@party_1.attendees).to eq([@user_2, @user_3])
    end
  end
end