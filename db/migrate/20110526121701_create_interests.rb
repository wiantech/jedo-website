class CreateInterests < ActiveRecord::Migration
  def self.up
    create_table :interests do |t|
      t.references :user
      t.integer :category_id
      t.integer :subcategory_id
      t.integer :position
      t.timestamps
    end
  end

  def self.down
    drop_table :interests
  end
end
