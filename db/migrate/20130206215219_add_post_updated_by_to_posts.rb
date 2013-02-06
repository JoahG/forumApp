class AddPostUpdatedByToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :post_updated_by, :integer
  end
end
