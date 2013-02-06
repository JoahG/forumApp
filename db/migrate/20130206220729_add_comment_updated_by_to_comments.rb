class AddCommentUpdatedByToComments < ActiveRecord::Migration
  def change
    add_column :comments, :comment_updated_by, :integer
  end
end
