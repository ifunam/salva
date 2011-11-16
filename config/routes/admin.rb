Salva::Application.routes.draw do

  namespace :admin do
    resources :users  do
      get :search_by_fullname, :on => :collection
      get :search_by_username, :on => :collection
      get :autocomplete_form, :on => :collection
      get :edit_status, :on => :member
      get :update_status, :on => :member
      get :user_incharge, :on => :member
    end

    resources :catalogs
    super_catalog_for :cities, :states, :journals, :publishers, :adscriptions, :researchareas,
                      :schoolarships, :institutions, :periods, :seminarytypes, :prizetypes, :careers,
                      :institutiontypes, :institutiontitles, :activitytypes, :academicprogramtypes,
                      :activitygroups, :addresstypes, :articlestatuses, :bookchaptertypes, :roleinbooks,
                      :booktypes, :conferencescopes, :conferencetypes,
                      :contracttypes, :coursegrouptypes, :credittypes, :degrees, :documenttypes,
                      :genericworkstatuses, :genericworktypes, :groups, :groupmodalities, :idtypes,
                      :languagelevels, :languages, :maritalstatuses, :mediatypes, :migratorystatuses,
                      :modalities, :roleinchapters, :roleinconferences, :roleinconferencetalks,
                      :roleincourses, :roles, :roleinjobpositions, :roleinjournals, :roleinjuries,
                      :roleinprojects, :roleinregularcourses, :roleinseminaries, :roleintheses,
                      :roleproceedings, :stimulustypes, :stimuluslevels, :studentroles, :talktypes,
                      :techproductstatuses, :titlemodalities, :thesisstatuses, :thesismodalities,
                      :userstatuses
  end

  mount Resque::Server.new, :at => '/admin/resque' if Rails.env.production?

end