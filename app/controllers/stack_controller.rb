class StackController < ApplicationController

  def index
    redirect_to :action => 'show'
  end

  def show
    @edit = session[:stack]
    @edit = nil if session[:stack] != nil and session[:stack].empty?

    @filter = session[:filter]
    @filter = nil if session[:filter] != nil and session[:filter].empty?
  end

end

