class MoveQueredFromUsersToParcels < ActiveRecord::Migration
  def change
    remove_column :users, :last_queryed, :datetime
    add_column :parcels, :queryed, :datetime
  end
end
