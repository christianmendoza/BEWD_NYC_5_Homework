class Movie < ActiveRecord::Base
  def self.get_all
    order(year_released: :asc)
    #readonly.all
  end
end
