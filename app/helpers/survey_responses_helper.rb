module SurveyResponsesHelper

  def survey_name(survey_response)
    if survey_response.survey.name.include?("#team")
      survey_response.survey.name.gsub("#team",survey_response.surveyable.name)
    elsif survey_response.survey.name.include?("#project")
      survey_response.survey.name.gsub("#project",survey_response.surveyable.name)
    else
      survey_response.survey.name
    end
  end  
end
