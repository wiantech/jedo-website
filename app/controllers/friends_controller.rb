class FriendsController < ApplicationController
  # GET /friends
  # GET /friends.xml
   before_filter :pending_friend
   def index
        user_type_admin=UserType.select("user_type").find(1)
        user_type_organisation=UserType.select("user_type").find(3)
        if !params[:search_friend].blank?
           @search_friend=params[:search_friend];
            if is_a_valid_email?(@search_friend)
                @users=User.select("users.id, users.first_name,users.email, users.last_name,users.photo_file_name,users.photo_file_size,fs.friend_id,fr.friend_id as frid ,fr.status").joins("LEFT JOIN friendships fs on users.id= fs.friend_id and fs.user_id =#{current_user.id} LEFT JOIN friends fr ON fr.friend_id =users.id and fr.user_id=#{current_user.id}").where("users.email LIKE '%#{@search_friend}%' AND users.id!=#{current_user.id} AND users.user_type !='#{user_type_admin[:user_type]}' AND users.user_type !='#{user_type_organisation[:user_type]}'").page(params[:page]).per(20)
            else
                @search_str= params[:search_friend].split(" ")
                @search_str[0]
                @search_str[1]
                if(@search_str[0]!=nil && @search_str[1] != nil)
                    @users=User.select("users.id, users.first_name,users.email, users.last_name,users.photo_file_name,users.photo_file_size,fs.friend_id,fr.friend_id as frid ,fr.status").joins("LEFT JOIN friendships fs on users.id= fs.friend_id and fs.user_id =#{current_user.id} LEFT JOIN friends fr ON fr.friend_id =users.id and fr.user_id=#{current_user.id}").where(" (users.first_name LIKE '%#{@search_str[0]}%' AND users.last_name like '%#{@search_str[1]}%' ) AND users.id !=#{current_user.id} AND users.user_type !='#{user_type_admin[:user_type]}' AND users.user_type !='#{user_type_organisation[:user_type]}'").page(params[:page]).per(20)
                elsif( @search_str[1]==nil)
                    @users=User.select("users.id, users.first_name,users.email, users.last_name,users.photo_file_name,users.photo_file_size,fs.friend_id,fr.friend_id as frid ,fr.status").joins("LEFT JOIN friendships fs on users.id= fs.friend_id and fs.user_id =#{current_user.id} LEFT JOIN friends fr ON fr.friend_id =users.id and fr.user_id=#{current_user.id}").where(" (users.first_name LIKE '%#{@search_str[0]}%' OR users.last_name like '%#{@search_str[0]}%')  AND users.id !=#{current_user.id} AND users.user_type !='#{user_type_admin[:user_type_admin]}' AND users.user_type !='#{user_type_organisation[:user_type]}'").page(params[:page]).per(20)
            end
        end
        else
        @frd_status=FriendshipStatus.select("value").find(2)
        @users=User.select("users.id, users.first_name, users.last_name,users.photo_file_name,users.photo_file_size, friendships.user_id, friendships.friend_id ,friendships.status").joins("INNER JOIN friendships ON friendships.friend_id=users.id").where("friendships.user_id=#{current_user.id} and friendships.status='#{@frd_status[:value]}'").page(params[:page]).per(20)
        end
        @frd_pending_status=FriendshipStatus.select("value").find(4) # use to checking pending status in search result page
        respond_to do |format|
        format.html # index.html.erb
        format.xml  { render :xml =>  @users }
        end
  end

  # GET /friends/1
  # GET /friends/1.xml

  # GET /friends/new
  # GET /friends/new.xml
  def new
      @friend = Friend.new
      respond_to do |format|
          format.html # new.html.erb
          format.xml  { render :xml => @friend }
      end
  end

  # GET /friends/1/edit
  def edit
      @friend = Friend.find(params[:id])
  end

  # POST /friends
  # POST /friends.xml
  def create
      @friend = Friend.new(params[:friend])
          respond_to do |format|
          if @friend.save
              format.html { redirect_to(@friend, :notice => 'Friend was successfully created.') }
              format.xml  { render :xml => @friend, :status => :created, :location => @friend }
          else
              format.html { render :action => "new" }
              format.xml  { render :xml => @friend.errors, :status => :unprocessable_entity }
          end
      end
  end
  # PUT /friends/1
  # PUT /friends/1.xml
  def update
      @friend = Friend.find(params[:id])
      respond_to do |format|
      if @friend.update_attributes(params[:friend])
          format.html { redirect_to(@friend, :notice => 'Friend was successfully updated.') }
          format.xml  { head :ok }
      else
          format.html { render :action => "edit" }
          format.xml  { render :xml => @friend.errors, :status => :unprocessable_entity }
      end
      end
  end
  # DELETE /friends/1
  # DELETE /friends/1.xml
  def destroy
      @friend = Friend.find(params[:id])
      @friend.destroy
      respond_to do |format|
          format.html { redirect_to(friends_url) }
          format.xml  { head :ok }
      end
  end

  # This action is performed while user want to
  def all_requests
      frd_status=FriendshipStatus.select("value").find(4)
      @mypending_friends=User.select("users.id,users.email, users.first_name ,users.last_name,users.photo_file_name,users.photo_file_size,friends.user_id,friends.friend_id ,friends.status").joins(:friends).where("friends.friend_id ='#{current_user.id}' and friends.status ='#{frd_status[:value]}'").order("friends.created_at DESC").page(params[:page]).per(20)
      respond_to do |format|
          format.html # new.html.erb
          format.xml  { render :xml =>@mypending_friends }
      end
  end

  # method is used for Send friend requests to friends
 def send_requests
     if !params[:id].blank?
      puts params[:id]
      @friend = Friend.new()
      @current_dt_time=Time.now.strftime("%Y-%m-%d %H:%M:%S")
      frd_pending_status=FriendshipStatus.select("value").find(4)
      @friend = Friend.new(:user_id=>"#{current_user.id}" ,:friend_id=>"#{params[:id]}",:status=>"#{frd_pending_status[:value]}",:created_at=>@current_dt_time,:updated_at=>@current_dt_time)
      end
          respond_to do |format|
              if @friend.save
              format.json {render :json => params[:id]}
              else
              format.json {render :nothing=>true}
              end
           end

 end

 # This method is used for friends acceptation
 def accept_friendship
          frd_status=FriendshipStatus.select("value").find(2)
          @friendship = Friendship.new()
          if((!params[:friendship_to].blank? )&& (!params[:friendship_from].blank?))
          @current_dt_time=Time.now.strftime("%Y-%m-%d %H:%M:%S")
          @to=params[:friendship_to]
          @from=params[:friendship_from]
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
        del=Friend.delete(@friend)
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

protected
def is_a_valid_email?(email)
# Check the number of '@' signs.
    if email.count("@") != 1 then
    return false
# We can now check the email using a simple regex.
# You can replace the TLD's at the end with the TLD's you wish
# to accept.
    elsif email =~ /^.*@.*(.com|.org|.net)$/ then
    return true
else
    return false
end
end

end
