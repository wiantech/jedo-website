class CreateOrganisations < ActiveRecord::Migration
  def self.up
    create_table :organisations do |t|
      t.string :name
      t.string :url
      t.references :user
      t.string :description
      t.references:state
      t.references:country
      t.string :flat
      t.string :street_number
      t.string :street_name
      t.string :city_name
      t.integer:postcode
      t.timestamps
    end
  end

  def self.down
    drop_table :organisations
  end
end
