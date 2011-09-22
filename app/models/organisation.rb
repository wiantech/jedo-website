class Organisation < ActiveRecord::Base
  belongs_to :user
  belongs_to :country
  belongs_to :state

  scope :find_organisation_user, lambda { |user_id|
      {
      :conditions => ["user_id= ?", user_id],
      :limit => 1
      }
  }
  attr_accessible :id,:name,:url,:user_id,:description,:state_id,:country_id,:flat,:street_number,:street_name,:city_name ,:postcode,:created_at,:updated_at

end
