class CreateProjectSponsors < ActiveRecord::Migration
  def change
    create_table :project_sponsors do |t|
	    t.integer :project_id
	  	t.integer :sponsor_id
	    t.timestamps
    end
  end
end
