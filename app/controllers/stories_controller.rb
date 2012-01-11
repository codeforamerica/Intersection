class StoriesController < InheritedResources::Base
  before_filter :authenticate_user!, :except => [:show, :index]
  respond_to :html, :js
  
  def index
    @search = Story.search(params[:search])
    @stories = @search
  end
  
  def create
    @story = current_user.stories.new(params[:story])
    
      if @story.save
        flash[:notice] = 'Story Saved'
        respond_with @story, :location => stories_url
      else
        respond_with @story
      end
  end

end
