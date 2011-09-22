class DashboardsController < ApplicationController
  before_filter :pending_friend
  layout 'application'
  require "addressable/uri"
  def index

  end
  # This method is used for friends acceptation
  def accept_friendship
      @friendship = Friendship.new()
  if((!params[:friendship_to].blank? )&& (!params[:friendship_from].blank?))
      @current_dt_time=Time.now.strftime("%Y-%m-%d %H:%M:%S")
      @to=params[:friendship_to]
      @from=params[:friendship_from]
      frd_status=FriendshipStatus.select("value").find(2)
      @friendship1 =Friendship.new(:user_id=>@to ,:friend_id=>@from,:status=>"#{frd_status[:value]}",:created_at=>@current_dt_time,:updated_at=>@current_dt_time)
      @friendship2 =Friendship.new(:user_id=>@from ,:friend_id=>@to,:status=>"#{frd_status[:value]}",:created_at=>@current_dt_time,:updated_at=>@current_dt_time)
      #remove friend request after having relationship
      @friend=Friend.select("id").where("user_id=#{params[:friendship_to]} and friend_id=#{params[:friendship_from]}")
      if !@friend.blank?
      Friend.delete(@friend)
      end
  end
      respond_to do |format|
          if @friendship1.save && @friendship2.save
          format.json {render :json => params[:friendship_to]}
          else
          format.json {render :nothing=>true}
          end
      end
  end
# End of the method which is used for friends acceptation

 # This method is used for friends acceptation
  def reject_friendship
      if((!params[:friendship_to].blank? ) && (!params[:friendship_from].blank?))
          @friend = Friend.select("id").where("user_id=#{params[:friendship_to]} and friend_id=#{params[:friendship_from]}")
          if !@friend.blank?
          del=Friend.destroy(@friend)
          end
      end
      respond_to do |format|
          if del
              format.json {render :json => params[:friendship_to]}
          else
              format.json {render :nothing=>true}
          end
      end
  end
 
# End of the method which is used for friends acceptation
  def my_events
      @my_events=Event.joins(:event_creator).where("event_creators.user_id=#{current_user.id}").order("created_at DESC").page(params[:page]).per(2)
  end

  def event_details
      if !params[:id].blank?
      @events=Event.select("`events`.*,`event_creators`.user_id,`event_creators`.event_id,`event_locations`.flat,`event_locations`.	street_number,`event_locations`.street_name ,`event_locations`.city_name,`event_locations`.post_code,`event_locations`.state_id,`event_locations`.country_id ").joins(:event_creator ,:event_location).where("event_creators.user_id=#{current_user.id} and event_creators.event_id=#{params[:id]}").limit(3)
      @user2=User.find(@events[0][:user_id])
      @event2=Event.find(@events[0][:id])
      @profile_type = UserType.find(:first, :conditions => ["id = ?",3 ])
      uri = Addressable::URI.parse(@events[0][:url])
      @uri_scheme=uri.scheme
     end
  end

 
  def del_event
      @event = Event.find(params[:id])
      @event.destroy
      respond_to do |format|
          format.html { redirect_to(my_events_dashboards_path ) }
          format.xml  { head :ok }
      end
  end


end
