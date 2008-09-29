ActionController::Routing::Routes.draw do |map|
  map.root :controller => 'sessions'
  map.resource  :session
  map.resources :users, :member => { :confirm => :get, :recovery_passwd_request => :get, :confirm => :get, :recovery_passwd => :post }
  map.resource  :user, :member => { :confirm => :get, :recovery_passwd_request => :get, :confirm => :get, :recovery_passwd => :post }
  map.resource  :change_password
  map.resource  :navigator
  map.resource  :person
  map.resources :addresses

  # Put them under admin namespace
  map.resources :academicprogramtypes
  map.resources :activitygroups
  map.resources :articlestatuses
  map.resources :bookchaptertypes
  map.resources :booktypes
  map.resources :userstatuses
  map.resources :userroles
  map.resources :titlemodalities
  map.resources :thesisstatuses
  map.resources :thesismodalities
  map.resources :techproducttypes
  map.resources :techproductstatuses
  map.resources :talktypes
  map.resources :talkacceptances
  map.resources :superscaffolds
  map.resources :studentroles
  map.resources :skilltypes
  map.resources :seminarytypes
  map.resources :roleproceedings
  map.resources :roleintheses
  map.resources :roleinseminaries
  map.resources :roleinregularcourses
  map.resources :roleinprojects
  map.resources :roleinjuries
  map.resources :roleinjournals
  map.resources :roleinjobpositions
  map.resources :roleincourses
  map.resources :roleinconferencetalks
  map.resources :roleinconferences
  map.resources :roleinchapters
  map.resources :roleinbooks
  map.resources :records
  map.resources :prizetypes
  map.resources :projecttypes
  map.resources :projectstatuses
  map.resources :modalities
  map.resources :migratorystatuses
  map.resources :mediatypes
  map.resources :languages
  map.resources :languagelevels
  map.resources :jobpositiontypes
  map.resources :jobpositionlevels
  map.resources :institutiontypes
  map.resources :institutiontitles
  map.resources :instadvicetargets
  map.resources :indivadvicetargets
  map.resources :idtypes
  map.resources :groupmodalities
  map.resources :genericworkstatuses
  map.resources :genericworkgroups
  map.resources :externaluserlevels
  map.resources :editionstatuses
  map.resources :degrees
  map.resources :coursegrouptypes
  map.resources :contracttypes
  map.resources :conferencetypes
  map.resources :conferencescopes
  map.resources :citizenmodalities
  map.resources :acadvisittypes
  map.resources :volumes
  

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
