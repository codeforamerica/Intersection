class ProjectsController < InheritedResources::Base
  before_filter :authenticate_user!, :except => [:index, :show]

  def index
    params[:search][:project_milestones_active_equals] = true if params[:search] and params[:search][:project_milestones_milestone_id_equals]!=0

    @search = Project.tagged_with(["qw"],:exclude => true).search(params[:search])

    if params[:search].nil?
      @search =  Project.tagged_with(["qw"],:exclude => true).search
    elsif  params[:search][:taggings_tag_name_contains] == "qw"
      @search = Project.search(params[:search])
    else
      @search = Project.tagged_with(["qw"],:exclude => true).search(params[:search])
    end

    @projects = @search.order("created_at DESC")
  end

  def show
    @project = params[:id].to_i==0 ? Project.where(:name => params[:id]).first : Project.find(params[:id])
  end


end
