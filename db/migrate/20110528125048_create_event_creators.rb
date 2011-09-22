class CreateEventCreators < ActiveRecord::Migration
  def self.up
    create_table :event_creators do |t|
      t.references:user
      t.references:event
      t.timestamps
    end
  end

  def self.down
    drop_table :event_creators
  end
end
