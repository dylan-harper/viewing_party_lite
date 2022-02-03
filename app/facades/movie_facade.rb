class MovieFacade

  def all_movies
    movie_data = []
    movie_data << service.get_movies_page_one[:results]
    movie_data << service.get_movies_page_two[:results]

    movie_data = movie_data.flatten

    @_all_movies = movie_data.map do |data|
      # require 'pry'; binding.pry
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

  def top_20
    sorted = all_movies.sort_by { |movie| movie.vote_average }
    sorted = sorted.reverse
    top_20 = sorted.take(20)
  end

  def self.search(query)
    json = MovieService.movie_search(query)
    results = json[:results].map do |movie|  
    MovieAPI.new(movie.slice(:id,
                         :title,
                         :poster_path,
                         :genre_ids,
                         :overview,
                         :vote_average,
                         :vote_count))
    end
  end

  def service
    @_service ||= MovieService.new
  end
end
