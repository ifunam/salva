class Department::ApplicationController < ActionController::Base
  protect_from_forgery
  skip_before_filter :authenticate_user!
  before_filter :authenticate_department!
  #alias :current_user :current_department

  layout :layout_by_resource

  def layout_by_resource
    if devise_controller?
      "devise"
    else
      "department"
    end
  end
end
