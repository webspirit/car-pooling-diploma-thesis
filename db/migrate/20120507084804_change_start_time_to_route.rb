class ChangeStartTimeToRoute < ActiveRecord::Migration
  def up
    change_column :routes, :start_time, :date
    rename_column :routes, :start_time, :date
    change_column :routes, :time_range_from, :time
    change_column :routes, :time_range_to, :time
  end
  
  def down
    change_column :routes, :date, :datetime
    rename_column :routes, :date, :start_time
    change_column :routes, :time_range_from, :datetime
    change_column :routes, :time_range_from, :datetime
  end

end
