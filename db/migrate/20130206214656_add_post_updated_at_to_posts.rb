class AddPostUpdatedAtToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :post_updated_at, :string
  end
end
