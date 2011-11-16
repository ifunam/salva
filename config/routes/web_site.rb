Salva::Application.routes.draw do
  namespace :web_site do
      match 'articles' => 'articles#index', :via => :get
  end
end
