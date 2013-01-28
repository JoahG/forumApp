class AddForumIdToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :forum_id, :integer, :default => 1
  end
end
