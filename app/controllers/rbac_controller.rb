class RbacController < ApplicationController
  helper :user
  layout "user"
  skip_before_filter :rbac_required
  public

  def index
  end
end
