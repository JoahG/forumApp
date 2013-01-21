class AddGplusToUsers < ActiveRecord::Migration
  def change
    add_column :users, :gplus, :string
  end
end
