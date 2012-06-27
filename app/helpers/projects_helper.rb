module ProjectsHelper

  def on_schedule(milestone_history)
    if milestone_history.completed_date.blank?
      if milestone_history.planned_date.present?
        schedule = milestone_history.planned_date.to_time - Time.now        
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

end
