class CreatePoints < ActiveRecord::Migration
  def change
    create_table :points do |t|
      t.decimal :departure_lat, :precision => 10, :scale => 5
      t.decimal :departure_lng, :precision => 10, :scale => 5
      t.decimal :arrival_lat, :precision => 10, :scale => 5
      t.decimal :arrival_lng, :precision => 10, :scale => 5
      t.text :departure_address
      t.text :arrival_address
      t.float :distance_departure_range
      t.float :distance_arrival_range
      t.datetime :start_time
      t.datetime :time_range_from
      t.datetime :time_range_to
      t.boolean :active
      t.integer :user_id

      t.timestamps
    end
  end
end
