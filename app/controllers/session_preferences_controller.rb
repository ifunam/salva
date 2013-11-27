class SessionPreferencesController < ApplicationController
  def enable_search
    enable_search!(true)
    render :nothing => true
  end

  def disable_search
    enable_search!(false)
    render :nothing => true
  end

  protected
  def enable_search!(val)
    if current_user.session_preference.nil?
      current_user.build_session_preference(:search_enabled => val).save
    else
      current_user.session_preference.update_attribute(:search_enabled, val)
    end
    session[:search_enabled] = val
  end

end
