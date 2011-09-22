class CreateEventBookings < ActiveRecord::Migration
  def self.up
    create_table :event_bookings do |t|
      t.references:event
      t.integer:booker_id
      t.string:status
      t.timestamps
    end
  end

  def self.down
    drop_table :event_bookings
  end
end
