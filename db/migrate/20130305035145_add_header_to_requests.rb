class AddHeaderToRequests < ActiveRecord::Migration
  def change
    add_column :requests, :header, :text
  end
end
