# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110920110726) do

  create_table "countries", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "event_bookings", :force => true do |t|
    t.integer  "event_id"
    t.integer  "booker_id"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "event_categories", :force => true do |t|
    t.integer  "event_id"
    t.integer  "category_id"
    t.integer  "subcategory_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "event_category_masters", :force => true do |t|
    t.string   "event_cat_name"
    t.integer  "parent_id"
    t.boolean  "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "event_creators", :force => true do |t|
    t.integer  "user_id"
    t.integer  "event_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "event_invitations", :force => true do |t|
    t.integer  "event_id"
    t.integer  "inviter_id"
    t.integer  "invitee_id"
    t.integer  "event_message_status_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "event_locations", :force => true do |t|
    t.integer  "event_id"
    t.string   "flat"
    t.string   "street_number"
    t.string   "street_name"
    t.string   "city_name"
    t.integer  "state_id"
    t.integer  "country_id"
    t.integer  "post_code"
    t.float    "latitude"
    t.float    "longitude"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "event_message_statuses", :force => true do |t|
    t.string   "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "event_recommendations", :force => true do |t|
    t.integer  "event_id"
    t.integer  "recommender_id"
    t.integer  "recommendee_id"
    t.integer  "event_message_status_id"
    t.integer  "recommendation_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "event_statuses", :force => true do |t|
    t.string   "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "events", :force => true do |t|
    t.string   "title"
    t.string   "url"
    t.string   "description"
    t.date     "start_date"
    t.date     "end_date"
    t.string   "start_time_hours"
    t.string   "start_time_minutes"
    t.string   "start_time_type"
    t.string   "end_time_hours"
    t.string   "end_time_minutes"
    t.string   "end_time_type"
    t.integer  "cost"
    t.integer  "capacity"
    t.integer  "booking"
    t.string   "status"
    t.string   "event_file_name"
    t.string   "event_content_type"
    t.integer  "event_file_size"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email"
    t.string   "cost_type"
    t.string   "mobile"
    t.string   "phone"
    t.string   "event_type",         :limit => 20
  end

  create_table "friends", :force => true do |t|
    t.integer  "user_id"
    t.integer  "friend_id"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "friendship_statuses", :force => true do |t|
    t.string   "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "friendships", :force => true do |t|
    t.integer  "user_id"
    t.integer  "friend_id"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "interests", :force => true do |t|
    t.integer  "user_id"
    t.integer  "category_id"
    t.integer  "subcategory_id"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "locations", :force => true do |t|
    t.integer  "user_id"
    t.integer  "state_id"
    t.integer  "country_id"
    t.float    "longitude"
    t.float    "latitude"
    t.string   "flat"
    t.string   "street_number"
    t.string   "street_name"
    t.string   "city_name"
    t.integer  "postcode"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "message_refferals", :force => true do |t|
    t.string   "msg_ref_to"
    t.integer  "msg_ref_from"
    t.integer  "message_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "messages", :force => true do |t|
    t.string   "msg_subject"
    t.string   "msg_body"
    t.boolean  "read"
    t.boolean  "unread"
    t.boolean  "status"
    t.datetime "msg_created"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "organisations", :force => true do |t|
    t.string   "name"
    t.string   "url"
    t.integer  "user_id"
    t.string   "description"
    t.integer  "state_id"
    t.integer  "country_id"
    t.string   "flat"
    t.string   "street_number"
    t.string   "street_name"
    t.string   "city_name"
    t.integer  "postcode"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "recommendation_types", :force => true do |t|
    t.string   "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "relationship_statuses", :force => true do |t|
    t.string   "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "services", :force => true do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "uid"
    t.string   "uname"
    t.string   "uemail"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "simple_captcha_data", :force => true do |t|
    t.string   "key",        :limit => 40
    t.string   "value",      :limit => 6
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "simple_captcha_data", ["key"], :name => "idx_key"

  create_table "states", :force => true do |t|
    t.string   "name"
    t.integer  "country_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_types", :force => true do |t|
    t.string   "user_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                                 :default => "", :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.string   "remember_token"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "user_type"
    t.string   "first_name"
    t.string   "last_name"
    t.date     "dob"
    t.string   "relationship"
    t.string   "gender"
    t.string   "status"
    t.string   "mobile"
    t.string   "phone"
    t.string   "alternate_email"
    t.string   "email_confirm"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.string   "photo_file_size"
    t.string   "authentication_token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["authentication_token"], :name => "index_users_on_authentication_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
