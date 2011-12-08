module ProjectsHelper

  def on_schedule(milestone_history) 
    schedule = milestone_history.planned_date.to_time - Time.now
    if !milestone_history.completed_date?
      if schedule < -1209600
        "red_schedule"
      elsif schedule < 0
        "yellow_schedule"
      elsif schedule > 0
        "green_schedule"
      end
    end
  end

end
