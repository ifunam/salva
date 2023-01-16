Rails.application.routes.draw do

  devise_for :departments, :path => '/department', :only => :sessions, :format => false,
             :controllers => { :sessions => "department/sessions" }

  namespace :department do
    resources :annual_reports, :only => [:index], :defaults => { :format => :html }
    get 'annual_reports/document', to: 'annual_reports#download_pdf'

    resources :annual_plans, :only => [:index], :defaults => { :format => :html }
    get 'annual_plans/document', to: 'annual_plans#download_pdf'

    root :to => "annual_reports#index"
  end

end