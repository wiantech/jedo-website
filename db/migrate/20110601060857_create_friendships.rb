class CreateFriendships < ActiveRecord::Migration
  def self.up
    create_table :friendships do |t|
      t.references :user
      t.integer    :friend_id
      t.string     :status
      t.timestamps
    end
  end

  def self.down
    drop_table :friendships
  end
end
