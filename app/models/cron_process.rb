class CronProcess

  def generate_survey_responses
    Survey.where("start_date <= ? and end_date >= ?", Time.now, Time.now).each do |survey|
      survey.generate_survey_responses if survey.survey_today?
    end
  end

end
