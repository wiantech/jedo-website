class State < ActiveRecord::Base
  belongs_to :country
  has_one :location
  has_one  :organisation
  scope:find_state, lambda{|country_id|
    {
      :conditions => ["country_id = ?", country_id],
      :order => "name asc"
    }
  }

end
