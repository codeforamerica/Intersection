class HomeController < ApplicationController
  def index
    @teams = Team.active_teams
    @fellows = Profile.where(:user_type => "Fellow")
    @projects = Project.featured
    @events = Event.all
    @network_size = @teams.map { |x| x.network_growth}
    @project_history = ProjectMilestone.where("active =?", true).order("updated_at DESC")
  end

end
