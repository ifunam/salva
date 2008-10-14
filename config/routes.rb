ActionController::Routing::Routes.draw do |map|
  map.root :controller => 'sessions'
  map.resource  :session
  map.resources :users, :member => { :confirm => :get, :recovery_passwd_request => :get, :confirm => :get, :recovery_passwd => :post }
  map.resource  :user, :member => { :confirm => :get, :recovery_passwd_request => :get, :confirm => :get, :recovery_passwd => :post }
  map.resource  :navigator

  map.resources :users, :shallow => true do |user|
    # RecordController
    user.resource :person

    user.resource :user_settings

    # SupperScaffoldController
    user.resources :addresses
    user.resources :citizens
    user.resources :person_identifications
    user.resources :user_languages
  end

  # ModelDependentMapperController
  map.resources :user_articles

  map.resources :admin do |admin|
    # Put them under admin namespace (SupperScaffoldController)
    admin.resources :academicprogramtypes
    admin.resources :activitygroups
    admin.resources :articlestatuses
    admin.resources :bookchaptertypes
    admin.resources :booktypes
    admin.resources :userstatuses
    admin.resources :userroles
    admin.resources :titlemodalities
    admin.resources :thesisstatuses
    admin.resources :thesismodalities
    admin.resources :techproducttypes
    admin.resources :techproductstatuses
    admin.resources :talktypes
    admin.resources :talkacceptances
    admin.resources :superscaffolds
    admin.resources :studentroles
    admin.resources :skilltypes
    admin.resources :seminarytypes
    admin.resources :roleproceedings
    admin.resources :roleintheses
    admin.resources :roleinseminaries
    admin.resources :roleinregularcourses
    admin.resources :roleinprojects
    admin.resources :roleinjuries
    admin.resources :roleinjournals
    admin.resources :roleinjobpositions
    admin.resources :roleincourses
    admin.resources :roleinconferencetalks
    admin.resources :roleinconferences
    admin.resources :roleinchapters
    admin.resources :roleinbooks
    admin.resources :records
    admin.resources :prizetypes
    admin.resources :projecttypes
    admin.resources :projectstatuses
    admin.resources :modalities
    admin.resources :migratorystatuses
    admin.resources :mediatypes
    admin.resources :languages
    admin.resources :languagelevels
    admin.resources :jobpositiontypes
    admin.resources :jobpositionlevels
    admin.resources :institutiontypes
    admin.resources :institutiontitles
    admin.resources :instadvicetargets
    admin.resources :indivadvicetargets
    admin.resources :idtypes
    admin.resources :groupmodalities
    admin.resources :genericworkstatuses
    admin.resources :genericworkgroups
    admin.resources :externaluserlevels
    admin.resources :editionstatuses
    admin.resources :degrees
    admin.resources :coursegrouptypes
    admin.resources :contracttypes
    admin.resources :conferencetypes
    admin.resources :conferencescopes
    admin.resources :citizenmodalities
    admin.resources :acadvisittypes
    admin.resources :volumes
  end

  map.namespace :public do |public|
        public.resources :our_people
  end

  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  # map.root :controller => "welcome"

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
  map.connect '', :controller => 'user', :action => 'index'
end
