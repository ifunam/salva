Rails.application.routes.draw do
  namespace :api do
    resources :adscriptions, :only => [:index, :show] do
      resources :users, :only => [:index]
    end
    resources :users, :only => [:show]
    #match 'users/find_by_login/:login' => 'users#find_by_login', :via => :get
    # Users with '.' in login error solved 
    match 'users/find_by_login/:login' => 'users#find_by_login', :login => /[^\/]+/, :via => :get
  end
end
