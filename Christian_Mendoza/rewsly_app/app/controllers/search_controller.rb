class SearchController < ApplicationController
  def index
    @stories = Story.search_for params[:q]
  end
end
