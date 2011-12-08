class Academic::SessionsController < ::Devise::SessionsController
  skip_before_filter :authenticate_user!
  layout "devise"
end
