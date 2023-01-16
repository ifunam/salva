Rails.application.routes.draw do
  namespace :administrator do
    resource :dashboard, :only => [:show]
    root :to => 'dashboards#show'
  end
    #mount RailsAdmin::Engine => '/admin_catalogs', :as => 'rails_admin'
    #mount Resque::Server.new, :at => '/admin_resque' if Rails.env.production?
    ActiveAdmin.routes(self)
  #end
end
