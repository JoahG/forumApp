class AddForumidToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :forumid, :integer, :default => 1
  end
end
