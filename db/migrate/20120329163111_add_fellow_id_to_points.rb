class AddFellowIdToPoints < ActiveRecord::Migration
  def self.up
    add_column :points, :fellow_id, :integer
  end
  def self.down
    remove_column :points, :fellow_id
  end
end
