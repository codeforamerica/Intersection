desc "This task is called by the Heroku cron add-on"
task :cron => :environment do
  CronProcess.new.delay.run_jobs
end
