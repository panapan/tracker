class AddExpandedToParcels < ActiveRecord::Migration
  def change
    add_column :parcels, :expanded, :boolean
  end
end
