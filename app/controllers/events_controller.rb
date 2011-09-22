class EventsController < ApplicationController
    layout 'application', :except =>[:preview_event]
    before_filter :pending_friend 
    # not used yet
    

    def index
        @events = Event.all
        respond_to do |format|
            format.html # index.html.erb
            format.xml  { render :xml => @events }
        end
    end

    # not used yet
    def show
        @event = Event.find(params[:id])
        respond_to do |format|
            format.html # show.html.erb
            format.xml  { render :xml => @event }
        end
    end

    # Create new event instance.
    def new
        @user_type_personal = UserType.select('user_type').where("id =2 ").first
        @user_type_organisational = UserType.select('user_type').where("id=3").first
        @event = Event.new
        @event_location = EventLocation.new
        @event_creator = EventCreator.new
        @event_category = EventCategory.new
        #@category = EventCategoryMaster.find_by_sql("SELECT * from event_category_masters where parent_id = 0")
        @category = EventCategoryMaster.find(:all, :conditions => ["parent_id = ?", 0])
        @country = Country.all
        respond_to do |format|
            format.html # new.html.erb
            format.xml  { render :xml => @event }
        end
    end
     # Update event for preview
    def update_event_for_preview
              if params[:preview] == 'Preview'
              @event = Event.find(params[:id])
              end_date=params[:event][:end_date].split("-")
              params[:event][:end_date]=end_date[2]+"-"+end_date[1]+"-"+end_date[0]
              @event_location = EventLocation.find(:first,:conditions=>["event_id= ?",params[:id]])
              if(params[:event][:cost_type]=='free')
              params[:event][:cost]=''
              end
              @event_category_data=EventCategory.find(:first, :conditions=>["event_id = ?",params[:id]])
              if params[:event][:event_type] =='Private'
              @event_category_data.update_attributes(:event_id=>params[:id],:category_id=>'' ,:subcategory_id=>'')
              elsif params[:event][:event_type] =='Public'
              @event_category_data.update_attributes(params[:event_categories])
              end
              respond_to do |format|
                  if @event.update_attributes(params[:event]) and @event_location.update_attributes(params[:event_location]) 

                      format.html { redirect_to( edit_previewevent_events_path(:id=>params[:id] ,:flag=>'preview'), :notice => 'Event was successfully updated.') }
                      format.xml  { head :ok }
                  else
                      format.html { render :action => "edit_previewevent_events" }
                      format.xml  { render :xml => @event.errors, :status => :unprocessable_entity }
                  end
              end

              else
             
              @event = Event.find(params[:id])
              end_date=params[:event][:end_date].split("-")
              params[:event][:end_date]=end_date[2]+"-"+end_date[1]+"-"+end_date[0]
              @event_location = EventLocation.find(:first,:conditions=>["event_id= ?",params[:id]])
              @event.status='active'
              @event_category_data=EventCategory.find(:first, :conditions=>["event_id = ?",params[:id]])
              if params[:event][:event_type] =='Private'
              @event_category_data.update_attributes(:event_id=>params[:id],:category_id=>'' ,:subcategory_id=>'')
              elsif params[:event][:event_type] =='Public'
              @event_category_data.update_attributes(params[:event_categories])
              end                   
              
              respond_to do |format|
                  if @event.update_attributes(params[:event]) and @event_location.update_attributes(params[:event_location]) 
                      format.html { redirect_to( my_events_dashboards_url, :notice => 'Event was successfully updated.') }
                      format.xml  { head :ok }
                  else
                      format.html { render :action => "edit_previewevent_events" }
                      format.xml  { render :xml => @event.errors, :status => :unprocessable_entity }
                  end
              end
              end
    end


    # Method for editing events details.
    def edit
        @user_type_personal = UserType.select('user_type').where("id =2 ").first
        @user_type_organisational = UserType.select('user_type').where("id=3").first
        @event = Event.find(params[:id])
        @country = Country.all
        @state = State.all
        @event_location = EventLocation.find(:first,:conditions=>["event_id= ?",params[:id]])
        @categoryMaster = EventCategoryMaster.find(:all, :conditions => ["parent_id = ?", 0])
        @event_category = EventCategory.all
        @event_category_data =  EventCategory.find(:first, :conditions=>["event_id = ?",params[:id]])
        @eventCategory = @event_category_data.category_id
        @eventSubCategory = @event_category_data.subcategory_id
        @event_category_category= EventCategoryMaster.find(:first, :conditions=> ["parent_id=?","#{@eventCategory}" ] )
        @event_subcategory_category=EventCategoryMaster.find(:first, :conditions=> ["parent_id=?","#{@eventSubCategory}" ] )
        @event_master = EventCategoryMaster.all
        @event_state= State.find(:all, :conditions=>["country_id=?",@event_location.country_id])
    end
    #Edit preview event
    def edit_previewevent
        @user_type_personal = UserType.select('user_type').where("id =2 ").first
        @user_type_organisational = UserType.select('user_type').where("id=3").first
        @checkpath=request.env["HTTP_REFERER"]
        @event = Event.find(params[:id])
        @country = Country.all
        @state = State.all
        @event_location = EventLocation.find(:first,:conditions=>["event_id= ?",params[:id]])
        @categoryMaster = EventCategoryMaster.find(:all, :conditions => ["parent_id = ?", 0])
        @event_category = EventCategory.all
        @event_category_data =  EventCategory.find(:first, :conditions=>["event_id = ?",params[:id]])
        @eventCategory = @event_category_data.category_id
        @eventSubCategory = @event_category_data.subcategory_id
        @event_category_category= EventCategoryMaster.find(:first, :conditions=> ["parent_id=?","#{@eventCategory}" ] )
        @event_subcategory_category=EventCategoryMaster.find(:first, :conditions=> ["parent_id=?","#{@eventSubCategory}" ] )
        @event_master = EventCategoryMaster.all
        @event_state= State.find(:all, :conditions=>["country_id=?",@event_location.country_id])
    end
    def add_event_for_preview
            start_date=params[:event][:start_date].split("-")
            end_date=params[:event][:end_date].split("-")
            params[:event][:start_date]=start_date[2]+"-"+start_date[1]+"-"+start_date[0]
            params[:event][:end_date]=end_date[2]+"-"+end_date[1]+"-"+end_date[0]

            @event = Event.new(params[:event])
            if(params[:event][:cost_type]=='free')
            @event.cost=''
            end
            @event.status='Inactive'

            @event_location = @event.build_event_location(params[:event_location])
            @event_creator = @event.build_event_creator(:user_id=>current_user.id)
            @event_category = @event.build_event_category(params[:event_category])

            respond_to do |format|
                if @event.save and  @event_creator.save and @event_location.save and @event_category.save
                    format.html { redirect_to(edit_previewevent_events_path(:id=>@event ,:flag=>'preview') ,:notice => 'Event was successfully created.') }
                    format.xml  { render :xml => @event, :status => :created, :location => @event }
                else
                    format.html { render :action => "new" }
                    format.xml  { render :xml => @event.errors, :status => :unprocessable_entity }
                end
            end

    end

    # Method for creating event.
    def create

        if params[:preview] == 'Preview'
            add_event_for_preview();

        else
            start_date=params[:event][:start_date].split("-")
            end_date=params[:event][:end_date].split("-")
            params[:event][:start_date]=start_date[2]+"-"+start_date[1]+"-"+start_date[0]
            params[:event][:end_date]=end_date[2]+"-"+end_date[1]+"-"+end_date[0]
            @event = Event.new(params[:event])
            @event.status='active'
            @event_location = @event.build_event_location(params[:event_location])
            @event_creator = @event.build_event_creator(:user_id=>current_user.id)
            if params[:event][:event_type] =='Private'
              params[:event][:category_id] =""
              params[:event][:subcategory_id] =""
            end
            @event_category = @event.build_event_category(params[:event_category])
            respond_to do |format|
                if @event.save and  @event_creator.save and @event_location.save and @event_category.save
                    format.html { redirect_to(dashboards_path, :notice => 'Event was successfully created.') }
                    format.xml  { render :xml => @event, :status => :created, :location => @event }
                else
                    format.html { render :action => "new" }
                    format.xml  { render :xml => @event.errors, :status => :unprocessable_entity }
                end
            end

        end

    end

    # Method for updating event details.
    def update

              @event = Event.find(params[:id])
              end_date=params[:event][:end_date].split("-")
              params[:event][:end_date]=end_date[2]+"-"+end_date[1]+"-"+end_date[0]
              @event_location = EventLocation.find(:first,:conditions=>["event_id= ?",params[:id]])
              respond_to do |format|
                  if @event.update_attributes(params[:event]) and @event_location.update_attributes(params[:event_location])
                    if params[:preview]=='Preview'
                    format.html { redirect_to( edit_event_path(:id=>params[:id] ,:flag=>'preview'), :notice => 'Event was successfully updated.') }
                    else
                    format.html { redirect_to( my_events_dashboards_url, :notice => 'Event was successfully updated.') }
                    end
                    format.xml  { head :ok }
                  else
                      format.html { render :action => "edit" }
                      format.xml  { render :xml => @event.errors, :status => :unprocessable_entity }
                  end
              end

    end

    #method for deleting event
    def destroy
        @event = Event.find(params[:id])
        @event.destroy
        respond_to do |format|
            format.html { redirect_to( my_events_dashboards_url) }
            format.xml  { head :ok }
        end
    end

    # Method returns subcategory based on category (Dynamic drop down list)
    def getsubcategory
      
        @subcategories = EventCategoryMaster.find( :all, :conditions => [" parent_id = ?", params[:id]]  ).sort_by{ |k| k['name'] }
        respond_to do |format|
            format.json  { render :json => @subcategories }
        end
    end


    # Method returns state based on Country (Dynamic drop down list)
    def getstate
        @states = State.find( :all, :conditions => [" country_id = ?", params[:id]]  ).sort_by{ |k| k['name'] }
        respond_to do |format|
            format.json  { render :json => @states }
        end
    end

    def preview_event
        if !params[:id].blank?
        @events=Event.select("`events`.*,`event_creators`.user_id,`event_creators`.event_id,`event_locations`.flat,`event_locations`.	street_number,`event_locations`.street_name ,`event_locations`.city_name,`event_locations`.post_code,`event_locations`.state_id,`event_locations`.country_id ").joins(:event_creator ,:event_location).where("event_creators.user_id=#{current_user.id} and events.id=#{params[:id]}").order('created_at DESC').limit(1)
        else
        @events=Event.select("`events`.*,`event_creators`.user_id,`event_creators`.event_id,`event_locations`.flat,`event_locations`.	street_number,`event_locations`.street_name ,`event_locations`.city_name,`event_locations`.post_code,`event_locations`.state_id,`event_locations`.country_id ").joins(:event_creator ,:event_location).where("event_creators.user_id=#{current_user.id} and events.status='Inactive'").order('created_at DESC').limit(1)
        end
        @user_type_organisation=UserType.find(3)
        @user2=User.find(@events[0][:user_id])
        @event2=Event.find(@events[0][:id])
        @profile_type = UserType.find(:first, :conditions => ["id = ?",3 ])
        @current_user_id=current_user.id
    end



end
