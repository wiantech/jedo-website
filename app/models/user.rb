class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable 


  # Setup accessible (or protected) attributes for your model
 attr_accessible :email, :password, :password_confirmation,:id, :remember_me ,:first_name,:last_name,:mobile,:phone,:alternate_email,:dob,:gender,:relationship,:user_type,:photo,:photo_file_name,:photo_content_type,:photo_file_size ,:organisation_attributes ,:location_attributes 
 has_attached_file :photo,:styles => {:thumb=> "41x41#", :small  => "100x100>" }
 has_one :location ,:dependent => :destroy
 has_one :organisation ,:dependent => :destroy
 has_many :services, :dependent => :destroy
 has_many :friends
 has_many :friendships
 has_many :event_creator
 has_one  :state, :through => :location
 has_many :events ,:through => :event_creator
 has_many :interests ,:dependent => :destroy
 accepts_nested_attributes_for :organisation
 accepts_nested_attributes_for :location
 
 devise :registerable
 devise :omniauthable

 def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["user_hash"]
        user.email = data["email"]
      end
    end
  end


 def self.find_for_facebook_oauth(access_token, signed_in_resource=nil)
  data = access_token['extra']['user_hash']
  if user = User.find_by_email(data["email"])
    user
  else # Create a user with a stub password.
    User.create!(:email => data["email"], :password => Devise.friendly_token[0,20] ,:first_name=>data["first_name"],:last_name=>data["last_name"])
  end
end 

#def with_postcode
# self.locations.build if self.locations.empty?
#end

#def update_with_password(params={})
#current_password = params.delete(:current_password) if !params[:current_password].blank?
#
#if params[:password].blank?
#  params.delete(:password)
#  params.delete(:password_confirmation) if params[:password_confirmation].blank?
#end
#
##
#result = if has_no_password?  || valid_password?(current_password)
#  update_attributes(params)
#else
#  self.errors.add(:current_password, current_password.blank? ? :blank : :invalid)
#  self.attributes = params
#  false
#end
#
#clean_up_passwords
#result
#end
#
#def has_no_password?
#  self.encrypted_password.blank?
#end
end
