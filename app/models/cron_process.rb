class CronProcess
  def run_jobs
    self.delay.generate_survey_responses
    self.delay.update_batchbook_lists
    self.delay.delete_expired_survey_responses
  end
  
  def generate_survey_responses
    Survey.where("start_date <= ? and end_date >= ?", Time.now, Time.now).each do |survey|
      survey.generate_survey_responses if survey.survey_today?
    end
  end
  
  def update_batchbook_lists
    BatchbookList.new.update_lists
  end

  def delete_expired_survey_responses
    Survey.all.each { |x| x.delete_expired_responses}
  end

  def is_it_friday?
    if Time.friday?
      User.all.each do |u|
        if u.new_surveys?
          UserMailer.delay.reminder_email(u)
        end
      end

    end
  end

end
