class AddLockVersionToEvents < ActiveRecord::Migration[8.0]
  def change
    add_column :events, :lock_version, :integer
    add_column :events, :available_tickets, :integer, default: 0, null: false
  end
end
