class CreateFriendshipStatuses < ActiveRecord::Migration
  def self.up
    create_table :friendship_statuses do |t|
      t.string :value
      t.timestamps
    end
  end

  def self.down
    drop_table :friendship_statuses
  end
end
