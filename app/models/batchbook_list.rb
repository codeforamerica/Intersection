class BatchbookList < ActiveRecord::Base
  belongs_to :team
  has_many :batchbook_list_histories, :dependent => :destroy

  def update_lists
    all_ids = BatchbookList.all.map(&:batchbook_id).uniq
    list = self.get_list
    parsed = parse_list(list.body)
    parsed.each do |list_id|
      if all_ids.include?(list_id["id"].to_i)
        BatchbookList.where(:batchbook_id => list_id["id"].to_i).each do |bb_lists|
          bb_lists.batchbook_list_histories.create!(:batchbook_list_id => list_id["id"], :contact_number => list_id["num_records"])
        end
      end
    end
    true
  end

  def get_list
    conn.get('/service/lists.xml?offset=0&limit=1000') 
  end

  def parse_list(xml_response)
    list = Ox.parse(xml_response)
    parsed = []
      list.locate('lists/?/').each do |l|
      parse_node = {}
      l.nodes.each do |node|
        parse_node["#{node.value}"] = node.nodes.first
      end
      parsed << parse_node
    end
    parsed 
    
  end

  def conn
    conn = Faraday.new(:url => 'https://codeforamerica.batchbook.com') do |builder|
      builder.request  :url_encoded
      builder.request  :json
      builder.response :logger
      builder.adapter  :net_http
    end
    conn.basic_auth ENV['batchbook_token'], ''
    conn
  end

end
