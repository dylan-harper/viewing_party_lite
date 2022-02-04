class UserPartyController < ApplicationController

  def new
    @movie = MovieFacade.movie_id_search(params[:movie_id])
    @user = User.find(params[:user_id])
    @users = User.all
  end

  def create
    party = Party.create!(duration: params[:duration].to_i,
                  date: params[:select_date],
                  start_time: params[:start_time],
                  movie_id: params[:movie_id])

    UserParty.create!(user_id: params[:user_id],
                       party_id: party.id,
                       status: "Host",)

    # @user = User.find(params[:user_id])

    redirect_to "/users/#{params[:user_id]}"
  end
end
