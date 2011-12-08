class BatchbookList < ActiveRecord::Base
  belongs_to :team
  has_many :batchbook_list_histories

  def update_list
     
  end

  def conn
    conn = Faraday.new(:url => 'https://codeforamerica.batchbook.com') do |builder|
      builder.request  :url_encoded
      builder.request  :json
      builder.response :logger
      builder.adapter  :net_http
    end
    conn.basic_auth ENV['batchbook_token'], ''
    return conn
  end

end
