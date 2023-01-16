class Bi::ApplicationController < ActionController::Base
  protect_from_forgery
  skip_before_action :authenticate_bi!
  before_action :authenticate_bi!
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
