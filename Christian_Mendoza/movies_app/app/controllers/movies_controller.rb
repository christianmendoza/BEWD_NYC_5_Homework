class MoviesController < ApplicationController
  def index
    @movies = Movie.get_all
  end

  def new
    @movie = Movie.instantiate_new
  end

  def create
    safe_movie = params.require(:movie).permit(:title, :description, :year_released, :rating)
    movie = Movie.create safe_movie
    redirect_to movie
  end

  def show
    @movie = Movie.find params[:id]
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    safe_movie = params.require(:movie).permit(:title, :description :year_released, :rating)
    @movie.update safe_movie
    redirect_to @movie
  end
end