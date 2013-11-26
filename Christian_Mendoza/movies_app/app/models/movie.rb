class Movie < ActiveRecord::Base
  validates :title, presence: true
  validates :description, length: { minimum: 10 }, presence: true
  validates :year_released, numericality: { greater_than: 0 }
  validates :rating, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }

  # All titles and descriptions must be present
  # Descriptions must be greater than 10 characters
  # Year released must be a number greater than 0
  # Rating must be a number between 1 and 5

  def self.create_new
    new
  end

  def create
    safe_movie = params.require(:movie).permit(:title, :description)
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
    safe_movie = params.require(:movie).permit(:title, :description)
    @movie.update safe_movie
    redirect_to @movie
  end

  def self.get_all
    #order(year_released: :asc)
    readonly.all
  end

  def self.search_for (query)
    where('title LIKE :query OR description LIKE :query OR year_released LIKE :query', query: "%#{query}%")
  end
end
