class RenameLinkToUrl < ActiveRecord::Migration
  def up
    remove_column :links, :link
    add_column :links, :url, :string
  end

  def down
    remove_column :links, :url
    add_column :links, :link, :string
  end
end
