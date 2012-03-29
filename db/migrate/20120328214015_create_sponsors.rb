class CreateSponsors < ActiveRecord::Migration
  def change
    create_table :sponsors do |t|
		t.string :name
		t.string :identity 
		t.string :email
		t.string :link
		t.timestamps
    end
  end
end
