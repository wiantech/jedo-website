class CreateEventLocations < ActiveRecord::Migration
  def self.up
    create_table :event_locations do |t|
      t.references :event
      t.string :flat
      t.string :street_number
      t.string :street_name
      t.string :city_name
      t.references :state
      t.references :country
      t.integer :post_code
      t.float :latitude
      t.float :longitude
      t.timestamps
    end
  end

  def self.down
    drop_table :event_locations
  end
end
