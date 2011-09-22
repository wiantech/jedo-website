class CreateMessageRefferals < ActiveRecord::Migration
  def self.up
    create_table :message_refferals do |t|
      t.string:msg_ref_to
      t.integer:msg_ref_from
      t.references:message			
      t.timestamps
    end
  end

  def self.down
    drop_table :message_refferals
  end
end
