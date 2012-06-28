class ProjectsController < InheritedResources::Base
  before_filter :authenticate_user!, :except => [:index, :show]

  def index
    @search = Project.tagged_with(["quick win"],:exclude => true).search(params[:search])

    if params[:search].nil?
      @search =  Project.tagged_with(["quick win"],:exclude => true).search
    elsif  params[:search][:taggings_tag_name_contains] == "quick win"
      @search = Project.search(params[:search])
    else
      @search = Project.tagged_with(["quick win"],:exclude => true).search(params[:search])
    end

    @projects = @search.order("created_at DESC")
  end

  def show
    @project = params[:id].to_i==0 ? Project.where(:name => params[:id]).first : Project.find(params[:id])
  end


end
