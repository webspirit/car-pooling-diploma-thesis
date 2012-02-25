class AddOfferToPoints < ActiveRecord::Migration
  def change
    add_column :points, :offer, :boolean

  end
end
