class SurveyResponsesController < ApplicationController
  before_filter :authenticate_user!

  def index
    @surveys = current_user.survey_responses.active
  end

  def update
    @survey_response = current_user.survey_responses.find(params[:id])
    @survey_response.update_attributes(params[:survey_response])
    respond_to do |format|
      format.js   { render :nothing => true }
    end
  end
end
