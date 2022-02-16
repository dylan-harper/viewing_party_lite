require 'rails_helper'

RSpec.describe User, type: :model do
  describe "validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :email}
    it { should validate_presence_of :password_digest}
    it { should have_secure_password}
    it { should validate_uniqueness_of :email}
  end

  describe 'relationships' do
     it { should have_many :user_parties }
     it { should have_many(:parties).through(:user_parties) }
  end

  before :each do
    @user_1 = create(:user)
    @user_2 = create(:user)
    @user_3 = create(:user)
    @user_4 = create(:user)

    num = 10
    # @movie1 = MovieFacade.all_movies.first
    # @movie2 = MovieFacade.all_movies.second
    # @movie3 = MovieFacade.all_movies.third
    # @movie4 = MovieFacade.all_movies.fourth

    @party_1 = create(:party, movie_id: num)
    @party_2 = create(:party, movie_id: num)
    @party_3 = create(:party, movie_id: num)
    @party_4 = create(:party, movie_id: num)

    @user_party_1 = create(:user_party, user_id: @user_1.id, party_id: @party_1.id)
    @user_party_2 = create(:user_party, user_id: @user_1.id, party_id: @party_2.id)
    @user_party_3 = create(:user_party, user_id: @user_1.id, party_id: @party_3.id)
    @user_party_4 = create(:user_party, user_id: @user_1.id, party_id: @party_4.id, status: "Host")
    @user_party_5 = create(:user_party, user_id: @user_2.id, party_id: @party_1.id)
    @user_party_6 = create(:user_party, user_id: @user_3.id, party_id: @party_1.id)
    @user_party_7 = create(:user_party, user_id: @user_3.id, party_id: @party_1.id)
    @user_party_8 = create(:user_party, user_id: @user_4.id, party_id: @party_1.id)
  end


  describe 'instance methods' do
    it '#invited_parties' do
      expect(@user_1.invites).to eq([@party_1, @party_2, @party_3])
    end
  end

  describe '#hosting' do
    it 'returns the parties that the user has created' do
      expect(@user_1.hosting).to eq([@party_4])
    end
  end

end
