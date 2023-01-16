Rails.application.routes.draw do
  namespace :web_site do
    #resources :annual_reports, :only => [:index]
    #resources :annual_plans, :only => [:index]

    resources :our_people, :only => [:index, :show] do
      get :list, :on => :collection
    end

    resources :home_pages, :only => [:show] do
      get :show_photo, :on => :member
    end

    resources :recent_publications, :only => [:index]
    resources :users, :only => [:index], :defaults => { :format => :html }
    resources :ka_labs, :only => [:index], :defaults => { :format => :json }
    resources :recent_publicationstl, :only => [:index], :defaults => { :format => :html }
  end
end
