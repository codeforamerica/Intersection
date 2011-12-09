class CronProcess
  def run_jobs
    self.delay.generate_survey_responses
    self.delay.update_batchbook_lists
  end
  
  def generate_survey_responses
    Survey.where("start_date <= ? and end_date >= ?", Time.now, Time.now).each do |survey|
      survey.generate_survey_responses if survey.survey_today?
    end
  end
  
  def update_batchbook_lists
    BatchbookList.new.update_lists
  end

end
