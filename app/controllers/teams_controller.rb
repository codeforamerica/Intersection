class TeamsController < InheritedResources::Base
  before_filter :authenticate_user!, :except => [:show, :index]
  before_filter :is_admin?, :only => [:new, :create, :destroy]
end
