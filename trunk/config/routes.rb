ActionController::Routing::Routes.draw do |map|
  map.resource  :person
  map.resources :addresses
  map.resources :genericworktypes
  map.resources :userconferences
  map.resources :user_genericworks
  map.resources :user_creditsbookeditions
  map.resources :teaching_activities
  map.resources :user_courses
  map.resources :jobposition_logs
  map.resources :regularcourses
  map.resources :projectarticles
  map.resources :published_articles
  map.resources :user_teaching_products
  map.resources :userstatuses
  map.resources :inproceeding_refereeds
  map.resources :bookedition_roleinbooks
  map.resources :volumes
  map.resources :bachelor_schoolings
  map.resources :diffusions
  map.resources :bookedition_publishers
  map.resources :researchlines
  map.resources :prizes
  map.resources :conferences
  map.resources :user_as_students
  map.resources :user_annual_activities_reports
  map.resources :books
  map.resources :roleinjobpositions
  map.resources :modalities
  map.resources :genericworks
  map.resources :jobpositionlevels
  map.resources :student_theses
  map.resources :unpublished_articles
  map.resources :outreachworks
  map.resources :proceeding_refereeds
  map.resources :indivadviceprograms
  map.resources :courses
  map.resources :reviews
  map.resources :professor_advices
  map.resources :institutiontitles
  map.resources :externaluserlevels
  map.resources :skilltypes
  map.resources :change_passwords
  map.resources :user_specialcourses
  map.resources :languages
  map.resources :roleincourses
  map.resources :academicprograms
  map.resources :projectgenericworks
  map.resources :techproducts
  map.resources :user_conferencetalks
  map.resources :user_theses
  map.resources :doctor_schoolings
  map.resources :conferencetypes
  map.resources :groups
  map.resources :acadvisittypes
  map.resources :schoolings
  map.resources :seminaries
  map.resources :user_creditsgenericworks
  map.resources :coursegrouptypes
  map.resources :user_creditsconferencetalks
  map.resources :careers
  map.resources :countries
  map.resources :user_seminaries
  map.resources :student_advices
  map.resources :userconference_committees
  map.resources :user_cites
  map.resources :newspapers
  map.resources :user_settings
  map.resources :institutions
  map.resources :newspaperarticles
  map.resources :roleingroups
  map.resources :prizetypes
  map.resources :popularscienceworks
  map.resources :inproceeding_unrefereeds
  map.resources :instadvicetargets
  map.resources :resumes
  map.resources :projectresearchareas
  map.resources :user_projects
  map.resources :talkacceptances
  map.resources :otherworks
  map.resources :stimulustypes
  map.resources :roleinregularcourses
  map.resources :user_newspaperarticles
  map.resources :stimuluslevels
  map.resources :schoolarships
  map.resources :jobposition_externals
  map.resources :master_schoolings
  map.resources :roleinconferencetalks
  map.resources :projectresearchlines
  map.resources :chapterinbook_roleinchapters
  map.resources :projectinstitutions
  map.resources :booktypes
  map.resources :bookchaptertypes
  map.resources :acadvisits
  map.resources :contracttypes
  map.resources :journals
  map.resources :user_unpublished_articles
  map.resources :tutorial_committees
  map.resources :coursegroups
  map.resources :user_techreports
  map.resources :projectacadvisits
  map.resources :user_articles
  map.resources :inproceedings
  map.resources :user_proceeding_refereeds
  map.resources :jobpositiontypes
  map.resources :multi_salvas
  map.resources :user_regularcourses
  map.resources :teaching_products
  map.resources :projectconferencetalks
  map.resources :credittypes
  map.resources :people_identifications
  map.resources :user_annual_activities_plans
  map.resources :identifications
  map.resources :user_document_handlings
  map.resources :credentials
  map.resources :roleinjournals
  map.resources :user_journals
  map.resources :user_languages
  map.resources :user_inproceeding_unrefereeds
  map.resources :citizenmodalities
  map.resources :user_books
  map.resources :coursedurations
  map.resources :thesis_committees
  map.resources :activitytypes
  map.resources :techproducttypes
  map.resources :projects
  map.resources :periods
  map.resources :projecttheses
  map.resources :techactivities
  map.resources :user_credits
  map.resources :user_inproceeding_refereeds
  map.resources :articles
  map.resources :proceedings
  map.resources :activities
  map.resources :genericworkgroups
  map.resources :talktypes
  map.resources :user_schoolarships
  map.resources :sponsor_acadvisits
  map.resources :user_prizes
  map.resources :mediatypes
  map.resources :user_inproceedings
  map.resources :techreports
  map.resources :roles
  map.resources :seminarytypes
  map.resources :professionaltitles
  map.resources :user_adscriptions
  map.resources :externalusers
  map.resources :instadvices
  map.resources :languagelevels
  map.resources :user_skills
  map.resources :titlemodalities
  map.resources :user_techproducts
  map.resources :bookeditions
  map.resources :institutiontypes
  map.resources :user_roleingroups
  map.resources :institutioncareers
  map.resources :jobposition_at_institutions
  map.resources :roleproceedings
  map.resources :user_cites_logs
  map.resources :idtypes
  map.resources :cities
  map.resources :conference_institutions
  map.resources :thesis_jurors
  map.resources :genericworkstatuses
  map.resources :user_popularscienceworks
  map.resources :bookedition_comments
  map.resources :conferencescopes
  map.resources :institutional_activities
  map.resources :chapterinbooks
  map.resources :memberships
  map.resources :user_researchlines
  map.resources :permissions
  map.resources :states
  map.resources :projectbooks
  map.resources :indivadvicetargets
  map.resources :user_outreachworks
  map.resources :degrees
  map.resources :user_published_articles
  map.resources :indivadvices
  map.resources :projectfinancingsources
  map.resources :user_creditsarticles
  map.resources :conferencetalks
  map.resources :researchareas
  map.resources :jobpositioncategories
  map.resources :proceeding_unrefereeds
  map.resources :citizens
  map.resources :other_schoolings
  map.resources :projectchapterinbooks
  map.resources :migratorystatuses
  map.resources :publishers
  map.resources :chapterinbook_comments
  map.resources :theses
  map.resources :adscriptions

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
