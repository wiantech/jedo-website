class CreateEventStatuses < ActiveRecord::Migration
  def self.up
    create_table :event_statuses do |t|
      t.string :value
      t.timestamps
    end
  end

  def self.down
    drop_table :event_statuses
  end
end
