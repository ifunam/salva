Rails.application.routes.draw do

  devise_for :academics, :path => '/academic', :only => :sessions, :format => false,
             :controllers => { :sessions => "academic/sessions" }

  namespace :academic do
    resources :annual_reports, :only => [:index, :edit, :update] do
      get :approve, :on => :member
    end

    resources :annual_plans, :only => [:index, :edit, :update] do
      get :approve, :on => :member
    end

    root :to => "annual_reports#index"
  end

end