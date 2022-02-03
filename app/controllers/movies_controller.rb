class MoviesController < ApplicationController


  def results
    @user = User.find(params[:id])
    @facade = MovieFacade.new
    if params[:q] == 'top20'
      @results = @facade.top_20
    elsif params[:keyword]
      @results = MovieFacade.search(params[:keyword])
    end
  end

  def show
    @movie = Movie.find(params[:id])
  end
end
