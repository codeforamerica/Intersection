class BatchbookListHistory < ActiveRecord::Base
  belongs_to :batchbook_list
  scope :during, lambda { |time1, time2| where("created_at BETWEEN ? and ?", time1, time2)}
end
