class MoviesController < ApplicationController
  before_action :find_movie, only: [:edit, :show, :update, :destroy]

  def index
    @movies = Movie.all
  end

  def create
    @movie = Movie.create safe_movie

    if @movie.save
      redirect_to @movie, notice: "The movie '#{@movie.title}' was added."
    else
      render 'new'
    end
  end

  def new
    @movie = Movie.new
  end

  def edit

  end

  def show
  
  end

  def update
    if @movie.update safe_movie
      redirect_to @movie, notice: "The movie '#{@movie.title}' was updated."
    else
      render 'edit'
    end
  end

  def destroy
    @movie.destroy
    redirect_to root_path, alert: "The movie '#{@movie.title}' was deleted."
  end

  private

  def safe_movie
    params.require(:movie).permit(:title, :description, :year_released, :rating)
  end

  def find_movie
    @movie = Movie.find params[:id]
  end
end
