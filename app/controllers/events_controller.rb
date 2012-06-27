class EventsController < InheritedResources::Base
  before_filter :authenticate_user!
  respond_to :html, :js
  
  def index
    @search = Event.search(params[:search]).order('event_date DESC')
    @events = @search
  end

  def create
    @event = Event.new(params[:event])
    if @event.save
      flash[:notice] = 'Event Saved'
      respond_with @event, :location => stories_url
    else
      respond_with @event
    end
  end
end
