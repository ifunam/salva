Salva::Application.routes.draw do
  namespace :web_site do
    resources :annual_reports, :only => [:index]
    resources :annual_plans, :only => [:index]
  end
end
