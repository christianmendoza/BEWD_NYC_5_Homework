class SearchController < ApplicationController
  def index
    query = params[:q]
    @movies = Movie.search_for query
  end
end
