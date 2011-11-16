Salva::Application.routes.draw do

  namespace :academic_secretary do
    resources :users  do
      get :search_by_fullname, :on => :collection
      get :search_by_username, :on => :collection
      get :autocomplete_form, :on => :collection
      get :list, :on => :collection
      get :edit_status, :on => :member
      get :update_status, :on => :member
      get :user_incharge, :on => :member
    end

    resources :identification_cards do
      get :front, :on => :member
      get :back, :on => :member
    end
  end

end
