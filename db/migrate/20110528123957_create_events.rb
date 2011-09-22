class CreateEvents < ActiveRecord::Migration
  def self.up
    create_table :events do |t|
      t.string :title
      t.string :url
      t.string :description
      t.date :start_date
      t.date :end_date
      t.string :start_time_hours
      t.string :start_time_minutes
      t.string :start_time_type
      t.string :end_time_hours
      t.string :end_time_minutes
      t.string :end_time_type
      t.integer :cost
      t.integer :capacity
      t.integer :booking
      t.string :status
      t.string :event_file_name
      t.string :event_content_type
      t.integer :event_file_size
      t.timestamps
    end
  end

  def self.down
    drop_table :events
  end
end
