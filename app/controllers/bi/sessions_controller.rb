class Bi::SessionsController < ::Devise::SessionsController
  skip_before_action :authenticate_user!, :only => [:create, :new]
  layout "devise"

  def create
     resource = warden.authenticate!(:scope => resource_name, :recall => "bi/sessions#new")
     set_flash_message(:notice, :signed_in) if is_navigational_format?
     sign_in(resource_name, resource)
     unless current_user.nil?
       if current_user.admin? or current_user.librarian?
         respond_with resource, :location => bi_verified_articles_path
       else
         redirect_to user_profile_path
       end
     else
       redirect_to bi_verified_articles_path
     end
  end
end


