class CreateEventCategories < ActiveRecord::Migration
  def self.up
    create_table :event_categories do |t|
      t.references :event
      t.integer :category_id
      t.integer :subcategory_id
      t.timestamps
    end
  end

  def self.down
    drop_table :event_categories
  end
end
