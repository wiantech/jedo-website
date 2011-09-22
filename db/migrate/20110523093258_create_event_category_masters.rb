class CreateEventCategoryMasters < ActiveRecord::Migration
  def self.up
    create_table :event_category_masters do |t|
      t.string :event_cat_name
      t.integer :parent_id
      t.boolean :status
      t.timestamps
    end
  end

  def self.down
    drop_table :event_category_masters
  end
end
