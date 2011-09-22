class UserType < ActiveRecord::Base
  scope :find_user_type, lambda { |type_id|
      {
      :conditions => ["id= ?", type_id],
      :limit => 1
      }
  }
end
