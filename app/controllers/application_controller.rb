class ApplicationController < ActionController::Base
  rescue_from DeviseLdapAuthenticatable::LdapException do |exception|
    render :text => exception, :status => 500
  end

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end

  def current_ability
    @current_ability ||= Ability.new(current_user)
  end

  def authorize_admin_action!
    unless current_user.admin?
      authorize! :unauthorized, :administrator, :message => I18n.t(:unauthorized)
    end
  end

  respond_to :html

  protect_from_forgery
  before_action :authenticate_user!
  layout :layout_by_resource
  # ensure_security_headers

  require 'active_admin_views_pages_base.rb'

  protected
  def layout_by_resource
    devise_controller? ? "devise" : "application"
  end
end
