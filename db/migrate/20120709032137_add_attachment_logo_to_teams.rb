class AddAttachmentLogoToTeams < ActiveRecord::Migration
  def self.up
    change_table :teams do |t|
      t.has_attached_file :logo
    end
  end

  def self.down
    drop_attached_file :teams, :logo
  end
end
