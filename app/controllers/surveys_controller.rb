class SurveysController < InheritedResources::Base
  before_filter :authenticate!
  before_filter :is_admin?
end
