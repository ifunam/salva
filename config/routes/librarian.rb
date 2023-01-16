Rails.application.routes.draw do
  namespace :librarian do 
    mount RailsAdmin::Engine => '/admin', :as => 'rails_admin_librarian'
  end
end

