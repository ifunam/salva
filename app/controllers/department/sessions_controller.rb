class Department::SessionsController < ::Devise::SessionsController
  skip_before_action :authenticate_user!, :only => [:create, :new]
  layout "devise"

  def create
     resource = warden.authenticate!(:scope => resource_name, :recall => "department/sessions#new")
     set_flash_message(:notice, :signed_in) if is_navigational_format?
     sign_in(resource_name, resource)
     unless current_user.nil?
       if current_user.head? or current_user.admin?
         respond_with resource, :location => department_annual_reports_path
       else
         redirect_to user_profile_path
       end
     else
       redirect_to user_login_path
     end
  end

end


