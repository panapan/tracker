class AddRecoveryToUsers < ActiveRecord::Migration
  def change
    # add_column :users, :recovery_digest, :string
    add_column :users, :recovery_time, :datetime
    add_column :users, :last_queryed, :datetime
  end
end
