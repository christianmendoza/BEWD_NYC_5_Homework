class StoriesController < ApplicationController
  before_action :find_story, only: [:show]

  def index
    @stories = Story.all
  end

  def show
  end

  private

  def find_story
    @story = Story.find params[:id]
  end
end
