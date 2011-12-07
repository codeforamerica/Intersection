class SurveysController < InheritedResources::Base
  before_filter :authenticate_user!
  before_filter :is_admin?
  
end
