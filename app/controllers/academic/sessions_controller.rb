class Academic::SessionsController < ::Devise::SessionsController
  skip_before_action :authenticate_user!, :only => [:create, :new]
  layout "devise"

  def create
     resource = warden.authenticate!(:scope => resource_name, :recall => "academic/sessions#new")
     set_flash_message(:notice, :signed_in) if is_navigational_format?
     sign_in(resource_name, resource)
     respond_with resource, :location => academic_annual_reports_path
  end
end


