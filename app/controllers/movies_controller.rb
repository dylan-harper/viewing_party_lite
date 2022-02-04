class MoviesController < ApplicationController
  def results
    @user = User.find(params[:user_id])

    if params[:q] == 'top20'
      @results = MovieFacade.top_20
    elsif params[:keyword]
      @results = MovieFacade.search(params[:keyword])
    end
  end

  def show
    @user = User.find(params[:user_id])
    @movie = MovieFacade.movie_id_search(params[:movie_id])
    @genres = MovieGenreFacade.genres(@movie.genre_ids)
    @cast = MovieCastFacade.first_10_cast_members(params[:movie_id])
    @reviews = MovieReviewFacade.reviews(params[:movie_id])
  end
end
