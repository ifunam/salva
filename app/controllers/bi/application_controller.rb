class Bi::ApplicationController < ActionController::Base
  protect_from_forgery
  skip_before_filter :authenticate_bi!
  before_filter :authenticate_bi!
  alias :current_user :current_bi

  layout :layout_by_resource

  def layout_by_resource
    if devise_controller?
      "devise"
    else
      "bi"
    end
  end
end
