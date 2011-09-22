class CreateEventMessageStatuses < ActiveRecord::Migration
  def self.up
    create_table :event_message_statuses do |t|
      t.string :value
      t.timestamps
    end
  end

  def self.down
    drop_table :event_message_statuses
  end
end
