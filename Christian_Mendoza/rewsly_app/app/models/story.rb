class Story < ActiveRecord::Base
  validates :title, :link, :category, :upvotes, presence: true
  validates :title, length: { minimum: 5 }
  validates :upvotes, numericality: { greater_than_or_equal_to: 0 }
  validate :valid_link

  def self.search_for query
    where('title LIKE :query OR category LIKE :query', query: "%#{query}%")
  end

  def self.get_stories
    # database 'created_at' column is UTC. Subtract 5 hours to get local date/time
    where("upvotes >= :minimum AND DATE(created_at, '-5 hour') = DATE(:current)", minimum: 4, current: Date.current)
  end

  def valid_link
    unless self.link.downcase.start_with?('http://')
      errors.add(:link, "must start with 'http://'")
    end
  end
end
