class CreateNestedComments < ActiveRecord::Migration
  def change
    create_table :nested_comments do |t|
      t.integer :comment_id
      t.string :content

      t.timestamps
    end
  end
end
