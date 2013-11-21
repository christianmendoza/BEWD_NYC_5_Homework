class MoviesController < ApplicationController
  def index
    @movies = Movie.get_all
  end
end
