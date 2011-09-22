class CreateMessages < ActiveRecord::Migration
  def self.up
    create_table :messages do |t|
	t.string :msg_subject	
	t.string :msg_body
	t.boolean:read
	t.boolean:unread
	t.boolean:status
	t.datetime:msg_created 	
	t.timestamps
    end
  	
  end

  def self.down
    drop_table :messages
  end

	
end
