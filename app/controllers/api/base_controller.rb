class Api::BaseController < ActionController::Base
  # skip_before_filter :authenticate_user!
  respond_to :xml
end