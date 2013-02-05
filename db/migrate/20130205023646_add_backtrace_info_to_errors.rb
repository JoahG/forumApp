class AddBacktraceInfoToErrors < ActiveRecord::Migration
  def change
    add_column :errors, :backtrace_info, :text
  end
end
