class TeamsController < InheritedResources::Base
  before_filter :authenticate_user!, :except => [:show, :index]
  before_filter :is_admin?, :only => [:new, :create, :destroy]

  def index
    @teams = Team.active_teams.order('sort_order')
  end

  def show
    @team = params[:id].to_i==0 ? Team.where(:name => params[:id]).first : Team.find(params[:id])
  end
end
