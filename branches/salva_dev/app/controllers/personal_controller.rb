class PersonalController < ApplicationController

  def index
    @edit = Personal.find(@session[:user])
    if @edit then
      show
    else
      new
    end
  end

  def show
    @edit = Personal.find(@session[:user])
#    render :action => 'show'
  end
  def new
    @edit = Personal.new
#    render :action => 'new'
  end
end
