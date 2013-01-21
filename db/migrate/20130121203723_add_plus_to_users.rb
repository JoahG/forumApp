class AddPlusToUsers < ActiveRecord::Migration
  def change
    add_column :users, :plus, :integer
  end
end
