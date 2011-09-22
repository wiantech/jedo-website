class RegistrationsController < Devise::RegistrationsController
include SimpleCaptcha::ControllerHelpers  
before_filter :authenticate_user!, :only => :token
before_filter :pending_friend ,:except => [:new ,:check_email,:validate_captcha,:create ,:termsandconditions]
layout "application", :except => [:new ,:termsandconditions]

  def new
      super
  end
  def create
    @user = User.new(params[:user])
    @location=@user.build_location(:postcode=>params[:location][:postcode]) 
    if @user.save
      flash[:notice] = "You have signed up successfully."
      redirect_to root_url
    else
      render :action => :new
    end
  end

    # Method for retrieving data related to personal user (edit)
    def person_profile_edit
      @category = EventCategoryMaster.find_category
      show_interest_data();
      @state1 = State.find_state(@location.country_id)
      respond_to do |format|
      format.html {render :editing_user_profile}
      format.xml  { render :xml => @user }
      end
    end

   # Method for retrieving data related to new user (edit)
    def new_profile_edit
      @category = EventCategoryMaster.find_category
      show_interest_data();
      respond_to do |format|
      format.html
      format.xml  { render :xml => @user }
      end
    end

  # Method for retrieving data related to organisational user (edit)
    def organisation_profile_edit
      @organisation = Organisation.find_organisation_user(params[:id]).first
      @user1 = @user
      @location1 = @location
      @state1 = State.find_state(@organisation.country_id)
      @state2 = State.find_state(@location1.country_id)
      respond_to do |format|
      format.html {render :editing_user_profile}
      format.xml  { render :xml => @user }
      end
    end
    
  def edit
      @country = Country.all
      @user=User.find(current_user.id)
      @organisation=Organisation.new()
      @location = Location.find_user_location(@user.id).first
      @userTypePersonal = UserType.find_user_type(2).first
      @userTypeOrganisational = UserType.find_user_type(3).first
      
      if (@user.user_type == nil)
      new_profile_edit();
      elsif(@user.user_type == @userTypePersonal.user_type)
      person_profile_edit();
      elsif(@user.user_type == @userTypeOrganisational.user_type)
      organisation_profile_edit();
      end
  end

   # This method is for showing data of i-like section(personal profile)
    def show_interest_data
        @interests = Interest.find_user_interest(current_user.id)
        @category_name = Array.new
        for i in 0..@interests.length-1 do
          @category_name[i] = EventCategoryMaster.find_category_name(@interests[i].category_id).first
        end
        @subcategory_name = Array.new
          for j in 0..@interests.length-1 do
          @subcategory_name[j] = EventCategoryMaster.find_category_name(@interests[j].subcategory_id).first
        end
          @show_interests = Array.new
        for p in 0..@interests.length-1 do
          @show_interests[p] = {"category_name" => "#{@category_name[p].event_cat_name}", "subcategory_name" => "#{@subcategory_name[p].event_cat_name}", "id" => "#{@interests[p].id}"}
        end
        
    end

    # This method is for retrieving data related to organisation profile.
    def organisation_data_for_show_method
        @location = @user.location
        @country = @location.country   # personal country name
        @state = @location.state     # personal state name
        @organisation = @user.organisation
        @organisation_country = @organisation.country
        @organisation_state = @organisation.state
  end

   # Method for validate Email-address
  def check_email
      @user = User.find_by_email(params[:user][:email])
      respond_to do |format|
      format.json {render :json => !@user}
      end
    end

     # Method for validate captcha
  def validate_captcha
      if simple_captcha_valid?
        @valid_cp=true
      else
        @valid_cp=false
      end
      respond_to do |format|
      format.json {render :json => @valid_cp}
      end
    end

 # Method returns state based on Country (Dynamic drop down list)
    def get_state
      @states = State.find_state(params[:id])
      respond_to do |format|
      format.json  { render :json => @states }
      end
    end

  # This method fetch subcategory from EventCategoryMaster table on OnChange event (for i like section)
    def get_subcategory
      @subcategories = EventCategoryMaster.find_subcategory(params[:id])
      respond_to do |format|
      format.json  { render :json => @subcategories }
      end
    end

   # Method for saving records related to new personal profile user (update)
    def new_personal_profile_update
        profile_type = UserType.find_user_type(2).first
        @user.user_type = profile_type.user_type
        params[:user][:user_type]=@user.user_type
        params[:user].delete(:password) if params[:user][:password].blank?
        params[:user].delete(:password_confirmation) if params[:user][:password].blank? and params[:user][:password_confirmation].blank?
        if @user.update_attributes(params[:user])
        flash[:notice] = "User was successfully updated."
        redirect_to dashboards_path
        else
        render :action => 'edit'
        end
   end

   # Method for saving records related to new organisation user (update)
    def new_organisational_profile_update
      profile_type = UserType.find_user_type(3).first
      @user.user_type = profile_type.user_type
      params[:user][:user_type]=@user.user_type
      params[:user].delete(:password) if params[:user][:password].blank?
      params[:user].delete(:password_confirmation) if params[:user][:password].blank? and params[:user][:password_confirmation].blank?
      respond_to do |format|
      if @user.update_attributes(params[:user])
        @organisation =@user.build_organisation(params[:organisation])
        @organisation.save 
        format.html { redirect_to(dashboards_path, :notice => 'User was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
      end
    end

    # Method for saving records related to reg. personal user (update)
    def reg_personal_profile_update
      respond_to do |format|
      if @user.update_attributes(params[:users]) 
        format.html { redirect_to(dashboards_path, :notice => 'User was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :editing_user_profile }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
      end
    end

     # Method for saving records related to reg. organisation user (update)
    def reg_organisation_profile_update
      @organisation = Organisation.find_organisation_user(params[:id]).first
      respond_to do |format|
      if  @user.update_attributes(params[:users1]) && @organisation.update_attributes(params[:organisations]) && @location.update_attributes(params[:locations1])
        format.html { redirect_to(dashboards_path, :notice => 'User was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :editing_user_profile }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
      end
    end

    # Method for  updating user_profile information
    def update
      @user = User.find(params[:user][:id])
      @location = Location.find_user_location(@user.id)
      personal = UserType.find_user_type(2).first
      organisational = UserType.find_user_type(3).first

      if (!params[:radio].blank? )
        if (params[:radio] == personal.user_type )
          new_personal_profile_update();
        elsif(params[:radio] == organisational.user_type)
          new_organisational_profile_update();
        end
      elsif (current_user.user_type == personal.user_type )
          reg_personal_profile_update();
      elsif (current_user.user_type == organisational.user_type )
          reg_organisation_profile_update();
      end
    end

    # save category_name & subcategory_name in interest_table
    def save_interest
      @record_count = Interest.find_all_by_user_id(current_user.id)
      @interest = Interest.new(:category_id => params[:category_id], :subcategory_id => params[:subcategory_id], :user_id => current_user.id)
      @same_pair = Interest.find_same_pair(params[:category_id], params[:subcategory_id], current_user.id)
      if (@same_pair.empty? && @record_count.count != 15)
        @interest.save
      else
        if(!@same_pair.empty?)
        @interest = {:message => "same pair."}
      elsif(@record_count.count == 15)
        @interest = {:message => "limit exceed."}
      end
      end
      respond_to do |format|
      format.json  { render :json => @interest }
      end
    end
    
    def profile_view
      @user = User.find(params[:id])
        @personal = UserType.find_user_type(2).first
        @organisational = UserType.find_user_type(3).first
        if @user.user_type == @personal.user_type
          @location = @user.location
          @country = @location.country   # personal country name
          @state = @location.state     # personal state name
          show_interest_data();
        elsif(@user.user_type == @organisational.user_type)
          organisation_data_for_show_method();
        end
        respond_to do |format|
        format.html # show.html.erb
        format.xml  { render :xml => @user }
        end
    end

    def termsandconditions
      
    end

end