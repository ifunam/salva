# Filters added to this controller will be run for all controllers in the application.
# Likewise, all the methods added will be available for all controllers.
require 'user_support'
class ApplicationController < ActionController::Base
  helper :ModelSecurity
  include UserSupport
  before_filter :user_setup 
end
