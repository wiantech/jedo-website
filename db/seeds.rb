# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

event_category_master =   EventCategoryMaster.create([
	{ :event_cat_name => 'Animals & Sea Life', :parent_id => 0},
	{ :event_cat_name => 'Pets', :parent_id => 1},
  { :event_cat_name => 'Acquarium', :parent_id => 1},
  { :event_cat_name => 'Zoo', :parent_id => 1},
  { :event_cat_name => 'Arts and Culture', :parent_id =>0},
  { :event_cat_name => 'Art Classes', :parent_id =>5},
  { :event_cat_name => 'Art Exhibitions & Visual Arts', :parent_id =>5},
  { :event_cat_name => 'History & Culture', :parent_id => 5},
  { :event_cat_name => 'Theatre & Performing Arts', :parent_id => 5},
  { :event_cat_name => 'Health & Beauty', :parent_id =>0},
  { :event_cat_name => 'Yoga & Pilates', :parent_id =>10},
  { :event_cat_name => 'Weight Loss', :parent_id =>10},
  { :event_cat_name => 'Meditation', :parent_id =>10},
  { :event_cat_name => 'Fashion', :parent_id =>10},
  { :event_cat_name => 'Beauty', :parent_id =>10},
  { :event_cat_name => 'Spa', :parent_id =>10},
  { :event_cat_name => 'Pamper for Couple', :parent_id =>10},
  { :event_cat_name => 'Cosmetics', :parent_id =>10},
  { :event_cat_name => 'Yoga & Pilates', :parent_id =>10},
  { :event_cat_name => 'Meditation', :parent_id =>10},
  { :event_cat_name => 'Books & Comics', :parent_id =>0},
  { :event_cat_name => 'Book Clubs', :parent_id =>21},
	{ :event_cat_name => 'Comics', :parent_id =>21},
	{ :event_cat_name => 'Book Launch', :parent_id =>21},
	{ :event_cat_name => 'Author Reading', :parent_id =>21},
	{ :event_cat_name => 'Business', :parent_id =>0},
	{ :event_cat_name => 'Networking', :parent_id =>26},
	{ :event_cat_name => 'Trade Shows & Conventions', :parent_id =>26},
	{ :event_cat_name => 'Clothes', :parent_id =>0},
	{ :event_cat_name => 'Clothes Swaps', :parent_id =>29},
	{ :event_cat_name => 'Clothes Markets', :parent_id =>29},
	{ :event_cat_name => 'Sewing/Knitting', :parent_id =>29},
	{ :event_cat_name => 'Dancing', :parent_id =>0},
	{ :event_cat_name => 'Latin', :parent_id =>33},
	{ :event_cat_name => 'Belly', :parent_id =>33},
	{ :event_cat_name => 'Folk', :parent_id =>33},
	{ :event_cat_name => 'Contemporary', :parent_id =>33},
	{ :event_cat_name => 'Ballroom', :parent_id =>33},
	{ :event_cat_name => 'Zumba', :parent_id =>33},
	{ :event_cat_name => 'Ballet', :parent_id =>33},
	{ :event_cat_name => 'Motorcycles', :parent_id =>0},
	{ :event_cat_name => 'Motorcycle Rides', :parent_id =>41},
	{ :event_cat_name => 'Motorycle Shows', :parent_id =>41},
	{ :event_cat_name => 'Scooter Shows', :parent_id =>41},
	{ :event_cat_name => 'Cars', :parent_id =>0},
	{ :event_cat_name => 'Advanced Driving', :parent_id =>45},
	{ :event_cat_name => 'Car Shows', :parent_id =>45},
	{ :event_cat_name => 'V8 Racing', :parent_id =>45},
	{ :event_cat_name => 'Off Road Driving', :parent_id =>45},
	{ :event_cat_name => 'Vehicle Maintenance', :parent_id =>45},
	{ :event_cat_name => 'Food & Drink', :parent_id =>0},
	{ :event_cat_name => 'Cooking', :parent_id =>51},
	{ :event_cat_name => 'Beer & Wine', :parent_id =>51},
	{ :event_cat_name => 'Dining Experiences', :parent_id =>51},
	{ :event_cat_name => 'Food Tours', :parent_id =>51},
	{ :event_cat_name => 'Markets', :parent_id =>51},
	{ :event_cat_name => 'Flying', :parent_id =>0},
	{ :event_cat_name => 'Flight Lessons', :parent_id =>57},
	{ :event_cat_name => 'Helicopter Flights', :parent_id =>57},
	{ :event_cat_name => 'Hot Air Ballooning', :parent_id =>57},
	{ :event_cat_name => 'Skydiving & Bungee Jumping', :parent_id =>57},
	{ :event_cat_name => 'Fitness', :parent_id =>0},
	{ :event_cat_name => 'Bodybuilding', :parent_id =>62},
	{ :event_cat_name => 'Walking', :parent_id =>62},
	{ :event_cat_name => 'Triathlons', :parent_id =>62},
	{ :event_cat_name => 'Running', :parent_id =>62},
	{ :event_cat_name => 'BootCamp', :parent_id =>62},
	{ :event_cat_name => 'Games', :parent_id =>0},
	{ :event_cat_name => 'Trivia', :parent_id =>68},
	{ :event_cat_name => 'Chess', :parent_id =>68},
	{ :event_cat_name => 'Paintball', :parent_id =>68},
	{ :event_cat_name => 'Online Gaming', :parent_id =>68},
	{ :event_cat_name => 'LAN Parties', :parent_id =>68},
	{ :event_cat_name => 'Poker', :parent_id =>68},
	{ :event_cat_name => 'Gardening & Flowers', :parent_id =>0},
	{ :event_cat_name => 'Flowers', :parent_id =>75},
	{ :event_cat_name => 'Gardens', :parent_id =>75},
	{ :event_cat_name => 'Investing', :parent_id =>0},
	{ :event_cat_name => 'Seminars', :parent_id =>78},
	{ :event_cat_name => 'Real Estate', :parent_id =>78},
	{ :event_cat_name => 'Kids & Family', :parent_id =>0},
	{ :event_cat_name => 'Mothers Groups', :parent_id =>81},
	{ :event_cat_name => 'Holiday Events', :parent_id =>81},
	{ :event_cat_name => 'Movies', :parent_id =>0},
	{ :event_cat_name => 'Special Events', :parent_id =>84},
	{ :event_cat_name => 'Moonlight', :parent_id =>84}
  ])


country = Country.create([
    {:name => 'India'},
    {:name => 'Australia'},
		{:name => 'US'},
		{:name => 'UK'}

  ])

state =  State.create([
    {:name => 'Maharashtra',:country_id=>1 },
		{:name => 'Gujarat',:country_id=>1 },
		{:name => 'Bengal',:country_id=>1 },
		{:name => 'Northern Territory',:country_id=>2 },
		{:name => 'Western Australia',:country_id=>2 },
		{:name => 'New South Wales',:country_id=>2 },
		{:name => 'South Australia',:country_id=>2 },
		{:name => 'Alaska AK',:country_id=>3 },
		{:name => 'Arizona AZ',:country_id=>3 },
		{:name => 'Arkansas AR',:country_id=>3 },
		{:name => 'Kent',:country_id=>4 },
		{:name => 'Manchester',:country_id=>4 },
		{:name => 'Essex',:country_id=>4 }
  ])


user_type = UserType.create([
		{:user_type => 'admin'},
		{:user_type => 'personal'},
		{:user_type => 'organisational'}

  ])
recommendation_type = RecommendationType.create([
    {:value =>"friend"},
    {:value =>"system"}
  ])

friendship_status = FriendshipStatus.create([
    {:value =>"ignore"},
    {:value =>"friend"},
    {:value =>"block"},
    {:value =>"pending"}
  ])

relationship_status = RelationshipStatus.create([
    {:value =>"married"},
    {:value =>"single"},
    {:value =>"rather not say"}
  ])