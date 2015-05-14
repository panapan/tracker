class CreateTracks < ActiveRecord::Migration
  def change
    create_table :tracks do |t|
      t.integer :track_id
      t.date :date
      t.time :time
      t.string :geo
      t.string :event
      t.integer :parcel_id

      t.timestamps null: false
    end
    add_index :tracks, [:parcel_id, :track_id]
  end
end
