class EventsController < InheritedResources::Base
  before_filter :authenticate_user!
  respond_to :html, :js
  
  def index
    @search = Event.search(params[:search])
    #@events = @search
    @events = Event.all
  end

  def show
    @event = Event.where(:id => params[:id])
  end

  def create
    @event = Event.new(params[:event])
    if @event.save
      flash[:notice] = 'Event Saved'
      respond_with @event, :location => stories_url
    else
      respond_with @event.errors
    end
  end
end
