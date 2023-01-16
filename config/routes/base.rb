Rails.application.routes.draw do

  devise_for :users, :only => :sessions
  resource :user_profile, :user_settings, :jobposition_log, :password, :user_cite

  # user_resources_for :user_languages, :user_skills, :user_schoolarships, :other_activities,
  #                    :popular_science_activities, :institutional_activities, :other_teaching_activities,
  #                    :technical_activities, :user_credits, :user_journals, :reviews, :student_advices,
  #                    :professor_advices, :institutional_advices, :user_stimuli, :memberships, :user_prizes,
  #                    :educations, :user_regular_courses, :user_refereed_journals, :tutorial_committees,
  #                    :jobpositions, :user_research_lines, :academic_exchanges, :external_jobpositions,
  #                    :user_lab_or_groups, :user_knowledge_areas, :videos

  # publication_resources_for :articles, :unpublished_articles, :popular_science_works, :outreach_works,
  #                           :other_works,:teaching_products, :technical_reports, :seminaries, :newspaper_articles,
  #                           :technical_products, :course_attendees, :course_instructors, :conference_attendees,
  #                           :conference_organizers, :regular_courses, :theses, :thesis_examinations,
  #                           :book_authors, :book_collaborations, :book_chapters, :conference_talks,
  #                           :projects, :refereed_inproceedings, :unrefereed_inproceedings, :proceeding_collaborations,
  #                           :selected_articles, :selected_books

  # catalog_resources_for :journals, :publishers, :institutions, :languages, :skilltypes, :research_areas,
  #                       :schoolarships, :credittypes, :newspapers, :careers, :techproducttypes, :stimuluslevels

  resources :states do
    get :list_by_country, :on => :collection
  end

  resources :cities do
    get :list_by_state, :on => :collection
    get :remote_form, :on => :collection
  end

  resources :jobpositioncategories do
     get :filtered_select, :on => :collection
  end

  resources :thesismodalities do
    get :list_by_degree, :on => :collection
  end

  resources :user_annual_reports, :only => [:index, :new, :create, :edit, :update, :show] do
    get :deliver, :on => :member
  end

  resources :user_annual_plans do
    get :deliver, :on => :member
  end

  resource :user_resume, :only => [:show]
  resources :emergency_info, :only => [:index], :defaults => { :format => :html }

  match '/session_preferences/enable_search' => 'session_preferences#enable_search', :via => :get
  match '/session_preferences/disable_search' => 'session_preferences#disable_search', :via => :get

  root :to => "user_profiles#show"
end
