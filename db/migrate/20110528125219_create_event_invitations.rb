class CreateEventInvitations < ActiveRecord::Migration
  def self.up
    create_table :event_invitations do |t|
      t.references :event
      t.integer :inviter_id
      t.integer :invitee_id
      t.integer :event_message_status_id
      t.timestamps
    end
  end

  def self.down
    drop_table :event_invitations
  end
end
