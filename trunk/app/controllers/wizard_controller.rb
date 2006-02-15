class WizardController < ApplicationController

  model :model_sequence

  def index
    render :action => 'new'
  end

  def get_sequence
     session[:sequence] 
  end
  
  def new
    sequence = get_sequence
    if sequence.is_composite 
      redirect_to :action => 'edit_multi'
    else
      @edit = sequence.get_model
    end
  end
 
  def edit
    sequence = get_sequence
    sequence.current = params[:current].to_i if params[:current] != nil
    @edit = sequence.get_model
  end
 
  def list
    sequence = get_sequence
    @list = sequence.sequence
  end
  
  def create
    mymodel = get_sequence.get_model
    @params[:edit].each { |key, value|
      mymodel[key.to_sym] = value
    }
    if mymodel.valid? then
      next_model 
    else
      sequence = get_sequence
      if sequence.is_composite
        render :action => 'edit_multi'
      else
        @edit = sequence.get_model
      end
      render :action => 'edit'
    end
  end
  
  def update
    sequence = get_sequence
    mymodel = sequence.get_model
    @params[:edit].each { |key, value|
      mymodel[key.to_sym] = value
    }	  
    if sequence.is_filled
      list
      redirect_to :action  => 'list'
    else	      
      next_model
    end
  end
  
  def previous_model
    sequence = get_sequence
    sequence.previous_model
    edit
    render :action => 'edit'
  end
  
  def next_model
    sequence = get_sequence
    if sequence.is_last
      redirect_to :action  => 'list'
    else
      sequence.next_model 
      if sequence.is_filled
        edit
      else
        new
      end
    end
  end
  
  def finalize
     sequence = get_sequence
     sequence.save
     redirect_to :controller => sequence.return_controller, :action => sequence.return_action
  end
  
  def cancel
     sequence = get_sequence
     redirect_to :controller => sequence.return_controller, :action => sequence.return_action
  end

  def edit_multi
    sequence = get_sequence
    composite = sequence.get_model
    @list = composite.get_children
    # @list = sequence.sequence if !@list
  end
	  
  def update_multi
     sequence = get_sequence
     sequence.sequence.each { |model|
	@params[:edit].each { |key, value|
	   model[key.to_sym] = value if model[key.to_sym] != nil
	}
     }
     redirect_to :action  => 'list'     
  end
						  
end
