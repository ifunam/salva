Salva::Application.routes.draw do
  namespace :api do
    resources :adscriptions, :only => [:index]
  end
end
