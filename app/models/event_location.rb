class EventLocation < ActiveRecord::Base
  belongs_to :event
  belongs_to :country
  belongs_to :state
end
