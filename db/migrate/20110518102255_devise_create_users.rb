class DeviseCreateUsers < ActiveRecord::Migration
  def self.up
    create_table(:users) do |t|
      t.database_authenticatable :null => false
      t.recoverable
      t.rememberable
      t.trackable
      t.string :user_type
      t.string :first_name
      t.string :last_name
      t.date :dob
      t.string :relationship
      t.string :gender
      t.string :status
      t.string :mobile
      t.string :phone
      t.string :alternate_email
      t.string :email_confirm
      t.string :photo_file_name
      t.string :photo_content_type
      t.string :photo_file_size
      # t.encryptable
      # t.confirmable
      # t.lockable :lock_strategy => :failed_attempts, :unlock_strategy => :both
      t.token_authenticatable


      t.timestamps
    end

    add_index :users, :email,                :unique => true
    add_index :users, :reset_password_token, :unique => true
    # add_index :users, :confirmation_token,   :unique => true
    # add_index :users, :unlock_token,         :unique => true
     add_index :users, :authentication_token, :unique => true
  end

  def self.down
    drop_table :users
  end
end
