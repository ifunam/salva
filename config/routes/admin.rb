Salva::Application.routes.draw do
  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'
  mount Resque::Server.new, :at => '/admin/resque' if Rails.env.production?
end
