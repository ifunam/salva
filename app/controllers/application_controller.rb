# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time

  before_filter :login_required
  #before_filter :navigator

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  #protect_from_forgery # :secret => '3ae605004c29b251466d3bbae32d99c5'

  def navigator
    @tree = Tree.find_by_data('default')
  end
  
  def update_partial
    render :partial => params[:partial]
  end

  def update_select
      render :partial => params[:partial], :locals => { :id => params[:id], :object => params[:object], :default => params[:default] }
  end

  def login_required
    store_location
    (!session[:user_id].nil? and !User.find(session[:user_id]).nil?) ? (return true) : (redirect_to :controller=> :sessions and return false)
  end

  def store_location
    session[:return_to] = request.request_uri
  end
  
  def set_user(model)
    unless session[:user_id].nil?
      model.user_id = session[:user_id] if model.has_attribute? 'user_id'
      model.moduser_id = session[:user_id] if model.has_attribute? 'user_id'
    end
  end

  def set_file(model, hash_name)
    file = params[hash_name][:file]
    if !file.nil? && (file.class == ActionController::UploadedTempfile || file.class == ActionController::UploadedStringIO)
      model.file = file.read
      model.content_type = file.content_type.chomp.to_s
      model.filename = file.original_filename.chomp
    end
  end
  
end
