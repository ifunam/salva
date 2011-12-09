Salva::Application.routes.draw do

  devise_for :academics, :path => '/academic', :only => :sessions,  :format => false,
             :controllers => { :sessions => "academic/sessions" }

  namespace :academic do
    resources :annual_reports, :only => [:index] do
      get :approve, :on => :member
      get :reject, :on => :member
    end

    resources :annual_plans, :only => [:index] do
      get :approve, :on => :member
      get :reject, :on => :member
    end

    root :to => "annual_reports#index"
  end

end