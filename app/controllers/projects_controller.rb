class ProjectsController < InheritedResources::Base
  before_filter :authenticate_user!, :except => [:index, :show]

  def index
    params[:search][:project_milestones_active_equals] = true if params[:search] and params[:search][:project_milestones_milestone_id_equals]!=0
    @search = Project.search(params[:search])
    @projects = @search.order(:created_at => "DESC")
  end

  def show
    @project = params[:id].to_i==0 ? Project.where(:name => params[:id]).first : Project.find(params[:id])
  end


end
