desc "This task is called by the Heroku cron add-on"
task :cron => :environment do
  CronProcess.new.generate_survey_responses
end
