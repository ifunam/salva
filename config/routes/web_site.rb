Salva::Application.routes.draw do
  namespace :web_site do
    resources :annual_reports, :only => [:index]
    resources :annual_plans, :only => [:index]

    resources :our_people, :only => [:index, :show] do
      get :list, :on => :collection
    end

    resources :home_pages, :only => [:show] do
      get :show_photo, :on => :member
    end

    get 'show_all_articles' => 'home_pages#show_all_articles', :as => 'show_all_articles'

    resources :recent_publications, :only => [:index]
  end
end
