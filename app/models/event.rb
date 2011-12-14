class Event < ActiveRecord::Base
  belongs_to :team
  order("event_date DESC")

  def self.grouped
    group("date(events.event_date)").size
  end
  
  def self.month_group
    events=self.grouped.map { |x| {"#{x[0].to_date.strftime("%m/%y")}" =>  x[1]} }
    events.inject{|memo, el| memo.merge( el ){|k, old_v, new_v| old_v + new_v}}
  end


end
