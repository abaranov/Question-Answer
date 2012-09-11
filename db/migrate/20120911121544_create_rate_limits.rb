class CreateRateLimits < ActiveRecord::Migration
  def change
    create_table :rate_limits do |t|
      t.integer :owner_id
      t.integer :issue_id

      t.timestamps
    end
    add_index :rate_limits, :owner_id
    add_index :rate_limits, :issue_id
    add_index :rate_limits, [:owner_id, :issue_id], :unique => true
  end
end
