class Location < ActiveRecord::Base
  belongs_to :user
  belongs_to :country
  belongs_to :state
  
  scope :find_user_location, lambda { |user_id|
      {
      :conditions => ["user_id= ?", user_id],
      :limit => 1
      }
  }
  
  attr_accessible :user_id ,:state_id,:country_id ,:longitude,:latitude,:flat,:street_number,:street_name,:city_name,:postcode,:created_at,:updated_at

end
