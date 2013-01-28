class RemoveForumidFromPosts < ActiveRecord::Migration
  def up
    remove_column :posts, :forumid
  end

  def down
    add_column :posts, :forumid, :integer
  end
end
