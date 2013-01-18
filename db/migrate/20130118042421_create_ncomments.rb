class CreateNcomments < ActiveRecord::Migration
  def change
    create_table :ncomments do |t|
      t.integer :comment_id
      t.integer :user_id
      t.string :content

      t.timestamps
    end
  end
end
