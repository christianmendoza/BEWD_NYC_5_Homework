class Movie < ActiveRecord::Base
  validates :title, presence: true
  validates :description, length: { minimum: 10 }, presence: true
  validates :year_released, numericality: { greater_than: 0 }, allow_blank: true
  validates :rating, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }, allow_blank: true

  # All titles and descriptions must be present
  # Descriptions must be greater than 10 characters
  # Year released must be a number greater than 0
  # Rating must be a number between 1 and 5

  def self.search_for (query)
    where('title LIKE :query OR description LIKE :query OR year_released LIKE :query', query: "%#{query}%")
  end
end
