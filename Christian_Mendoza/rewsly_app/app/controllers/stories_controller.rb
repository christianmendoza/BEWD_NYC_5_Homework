class StoriesController < ApplicationController
  before_action :find_story, only: [:show]

  def index
    @stories = Story.get_stories
  end

  def all
    @stories = Story.all
  end

  def create
    @story = Story.create safe_story

    if @story.save
      redirect_to @story, notice: "The story '#{@story.title}' was added."
    else
      render 'new'
    end
  end

  def new
    @story = Story.new
  end

  def show
  end

  private

  def find_story
    @story = Story.find params[:id]
  end

  def safe_story
    params.require(:story).permit(:title, :link, :category, :upvotes)
  end
end
