class AddExceptionNameToErrors < ActiveRecord::Migration
  def change
    add_column :errors, :exception_name, :string
  end
end
