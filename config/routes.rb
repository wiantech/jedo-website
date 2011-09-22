NewJedo::Application.routes.draw do
  resources :home
  
  resources :dashboards do
       collection do
         get :accept_friendship
         get :reject_friendship
         get :my_events
         get :event_details
         get :del_event
      end
      match ':dashboards(/:event_details(/:id))' =>'dashboards#event_details'
      match ':dashboards(/:del_event(/:id))' =>'dashboards#del_event'
   end
resources :events do
    collection do
      get :getsubcategory
      get :getstate
      get :preview_event
      get:edit_previewevent
      post:update_event_for_preview
      end


  end
  #match ":controller(/:action)", :controller => /sandbox\/[^\/]+/
  #match '/simple_captcha/:id', :to => 'simple_captcha#show', :as => :simple_captcha
  
  devise_for :users ,:controllers => {:registrations => "registrations" , :omniauth_callbacks => "omniauth_callbacks" ,:passwords=>"passwords"}  do
                get "/sign_in" => "devise/sessions#new"                 
                get "check_email" => "registrations#check_email"
                get "validate_captcha" => "registrations#validate_captcha"
                get "get_state" => "registrations#get_state"
                get "get_subcategory" => "registrations#get_subcategory"
                get "save_interest" => "registrations#save_interest"
                get "profile_view" => "registrations#profile_view"
                get 'auth/:provider' => 'omniauth_callbacks#passthru'
                get 'auth/failure'=> 'omniauth_callbacks#failure'
                get 'sign_out', :to => 'sessions#destroy', :as => :destroy_user_session
                get "termsandconditions" => "registrations#termsandconditions"
               
  end

  resources :friends do
       collection do
         get :all_requests
         get :send_requests
         get :accept_friendship
         get :reject_friendship
        # get :view_profile
      end
   match ':friends(/:send_requests(/:id))' =>'friends#send_requests'
  # match ':friends(/:view_profile(/:id))' =>'friends#view_profile'
  end
  #resources :services, :only => [:index, :create ,:destroy]
  #match '/auth/facebook/callback' => 'services#create'
  
  # The priority is based upon order of creation:
  # first created -> highest priority.
  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action
  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
   root :to => "home#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
