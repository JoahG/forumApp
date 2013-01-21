class RemovePlusFromUsers < ActiveRecord::Migration
  def up
    remove_column :users, :plus
  end

  def down
    add_column :users, :plus, :integer
  end
end
