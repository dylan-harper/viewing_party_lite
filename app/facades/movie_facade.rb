class MovieFacade

  def all_movies
    movie_data = []
    movie_data << service.get_movies_page_one[:results]
    movie_data << service.get_movies_page_two[:results]

    movie_data = movie_data.flatten

    @_all_movies = movie_data.map do |data|

      MovieAPI.new(data.slice(:id,
                           :title,
                           :poster_path,
                           :genre_ids,
                           :overview,
                           :vote_average,
                           :vote_count))

    end

    @_all_movies
  end


  def service
    @_service ||= MovieService.new
  end
end