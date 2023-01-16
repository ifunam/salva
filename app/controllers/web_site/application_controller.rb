class WebSite::ApplicationController < ActionController::Base
  layout 'web_site'
  helper :application, :i18n
  before_action :set_locale

  def set_locale
    I18n.locale = params[:locale]
  end
end