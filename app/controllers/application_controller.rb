class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user
  helper_method :user_signed_in?

  private
    

    def after_sign_in_path_for(resource)
    dashboards_url
    end
    def after_sign_out_path_for(resource_or_scope)
    root_path
    end
    def sign_out_and_redirect(resource_or_scope)
    scope = Devise::Mapping.find_scope!(resource_or_scope)
    Devise.sign_out_all_scopes ? sign_out : sign_out(scope)
    redirect_to after_sign_out_path_for(scope)
    end

     def pending_friend
      frd_pending_status=FriendshipStatus.select("value").find(4)
      @pending_friends=User.select("users.id , users.first_name ,users.last_name,users.photo_file_name,users.photo_file_size,friends.user_id,friends.friend_id ,friends.status").joins(:friends).where("friends.friend_id ='#{current_user.id}' and friends.status ='#{frd_pending_status[:value]}'").order("friends.created_at DESC").limit(3)
      @pending_friends2=User.select("users.id , users.first_name ,users.last_name,users.photo_file_name,users.photo_file_size,friends.user_id,friends.friend_id ,friends.status").joins(:friends).where("friends.friend_id ='#{current_user.id}' and friends.status ='#{frd_pending_status[:value]}'").order("friends.created_at DESC")
      @Myfrined=User.select("users.id, users.first_name, users.last_name, users.photo_file_name,users.photo_file_size,friendships.user_id, friendships.friend_id ,friendships.status").joins("INNER JOIN friendships ON friendships.friend_id=users.id ").where("friendships.user_id=#{current_user.id}").limit(6)
      @Myfrined2=User.select("users.id, users.first_name, users.last_name, users.photo_file_name,users.photo_file_size,friendships.user_id, friendships.friend_id ,friendships.status").joins("INNER JOIN friendships ON friendships.friend_id=users.id ").where("friendships.user_id=#{current_user.id}")
      @user_type_organisation=UserType.find(3)
      # Use to validate user profile
    end

     

end
