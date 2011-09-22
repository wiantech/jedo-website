class CreateLocations < ActiveRecord::Migration
  def self.up
    create_table :locations do |t|
      t.references :user
      t.references :state
      t.references :country        
      t.float      :longitude
      t.float      :latitude
      t.string     :flat
      t.string     :street_number
      t.string     :street_name
      t.string     :city_name
      t.integer    :postcode
      t.timestamps
      
    end
  end

  def self.down
    drop_table :locations
  end
end
