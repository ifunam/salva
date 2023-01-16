Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  [:academic, :api, :base, :bi, :department, :librarian, :web_site ].each do |route|
    draw(route)
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
