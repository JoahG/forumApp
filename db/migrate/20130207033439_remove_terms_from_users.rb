class RemoveTermsFromUsers < ActiveRecord::Migration
  def up
    remove_column :users, :terms
  end

  def down
    add_column :users, :terms, :boolean
  end
end
