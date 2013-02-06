class AddCommentUpdatedAtToComments < ActiveRecord::Migration
  def change
    add_column :comments, :comment_updated_at, :string
  end
end
