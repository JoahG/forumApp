class AddSociallinkToUsers < ActiveRecord::Migration
  def change
    add_column :users, :sociallink, :string
  end
end
