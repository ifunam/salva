class StackController < ApplicationController

  def index
    redirect_to :action => 'new'
  end

  def new
    if session[:stack] != nil 
      stack = session[:stack]
      if (session[:stack].size > 1)
        @edit = stack.get_model.new
      end
    end
  end

  def create
    if session[:stack] != nil
      stack = session[:stack]

#      model = stack.get_model
#      params[:edit].each { |key, value|
#        model[key.to_sym] = value
#      }
#      model.save if model.valid?

      stack.pop

      if (stack.top?)
        redirect_to :controller  => stack.get_controller, :action => stack.get_action
      else
        redirect_to :action => 'new'
      end
    end
  end
  
  def cancel
    if session[:stack] != nil
      stack = session[:stack]
      stack.pop
    end
    if (session[:stack].top?)
      redirect_to :controller  => stack.get_controller, :action => stack.get_action
    else
      redirect_to :action => 'new'
    end
  end

  def stack
    stack = session[:stack]
    stack.push(params[:handler], 'new')
    redirect_to :action => 'new'
  end

end

