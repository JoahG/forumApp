class CreatePlusones < ActiveRecord::Migration
  def change
    create_table :plusones do |t|
      t.integer :user_id
      t.integer :comment_id

      t.timestamps
    end
  end
end
