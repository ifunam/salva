Rails.application.routes.draw do

  devise_for :bi, :path => '/bi', :only => :sessions, :format => false,
             :controllers => { :sessions => "bi/sessions" }

  namespace :bi do
    root :to => "verified_articles#show_graph"
    get 'verified_articles' => 'verified_articles#show_graph'
    resources :impact_factors, :only => [:index], :defaults => { :format => :html }
    resources :researcher_adscriptions, :only => [:index], :defaults => { :format => :html }
    resources :researcher_categories, :only => [:index], :defaults => { :format => :html }
    resources :researcher_ages, :only => [:index], :defaults => { :format => :html }
    resources :knowledge_fields, :only => [:index], :defaults => { :format => :html }
    resources :knowledge_areas, :only => [:index], :defaults => { :format => :html }
    resources :theses, :only => [:index], :defaults => { :format => :html }
    resources :regular_courses, :only => [:index], :defaults => { :format => :html }
    resources :refereed_proceedings, :only => [:index], :defaults => { :format => :html }
    resources :unrefereed_proceedings, :only => [:index], :defaults => { :format => :html }
    resources :books, :only => [:index], :defaults => { :format => :html }
    resources :students, :only => [:index], :defaults => { :format => :html }

    resources :emergency_info, :only => [:index], :defaults => { :format => :html }

  end
end
