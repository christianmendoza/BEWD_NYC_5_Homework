class Story < ActiveRecord::Base
  validates :title, :link, :category, :upvotes, presence: true
  validates :title, length: { minimum: 5 }
  validates :upvotes, numericality: { greater_than_or_equal_to: 0 }
  validate :valid_link

  def self.search_for query
    where('title LIKE :query OR category LIKE :query', query: "%#{query}%")
  end

  def self.get_stories
    where("upvotes >= 4")
  end

  def valid_link
    unless self.link.downcase.start_with?('http://')
      errors.add(:link, "must start with 'http://'")
    end
  end
end
