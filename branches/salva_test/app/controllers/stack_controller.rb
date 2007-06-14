class StackController < ApplicationController

  def index
    redirect_to :action => 'show'
  end

  def show
    @edit = session[:stack]
    @edit = nil if session[:stack] != nil and session[:stack].empty?
  end

end

