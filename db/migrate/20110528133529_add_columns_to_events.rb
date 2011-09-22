class AddColumnsToEvents < ActiveRecord::Migration
  def self.up
    add_column :events, :email, :string
    add_column :events, :cost_type, :string
    add_column :events, :mobile, :string
    add_column :events, :phone, :string
    add_column:events, :event_type, :string ,:limit =>20
  end

  def self.down
    remove_column :events, :email
    remove_column :events, :cost_type
    remove_column :events, :mobile
    remove_column :events, :phone
   remove_column:events, :event_type
  end
end
