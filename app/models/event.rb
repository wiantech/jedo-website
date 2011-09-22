class Event < ActiveRecord::Base
  has_attached_file :event,:styles => {:thumb=> "107x80#", :small  => "246x151>" }
  has_one  :event_category, :dependent => :destroy
  has_one :event_creator, :dependent => :destroy
  has_one :event_location, :dependent => :destroy
  has_one :state ,:through => :event_location
  has_one :country ,:through => :event_location
  #validates :title,:description,:start_date,:end_date,:url,:flat,:street_name,  :presence => true
  #attr_accessible :title, :description
end
