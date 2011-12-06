class CronProcess

  def generate_survey_responses
    Survey.active_surveys.each do |survey|
      survey.generate_survey_responses if survey.survey_today?
    end
  end

end
