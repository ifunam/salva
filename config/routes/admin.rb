Salva::Application.routes.draw do
  namespace :admin do
    resource :dashboard, :only => [:show]
    root :to => 'dashboards#show'
  end
  mount RailsAdmin::Engine => '/admin/catalogs', :as => 'rails_admin'
  mount Resque::Server.new, :at => '/admin/resque' if Rails.env.production?
end
