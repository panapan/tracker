class CreateParcels < ActiveRecord::Migration
  def change
    create_table :parcels do |t|
      t.string :num
      t.string :note
      t.string :carrier
      t.boolean :delivered
      t.string :from_loc
      t.string :to_loc
      t.datetime :from_time
      t.datetime :to_time
      t.integer :user_id

      t.timestamps null: false
    end
    add_index :parcels, [:user_id, :created_at]
  end
end
