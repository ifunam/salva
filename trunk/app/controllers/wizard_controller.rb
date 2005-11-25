class WizardController < ApplicationController

  model :model_sequence

  def index
    new
    render :action => 'new'
  end

  def get_sequence
     session[:sequence] 
  end
  
  def new
    sequence = get_sequence
    @edit = sequence.get_model
  end
 
  def edit
    sequence = get_sequence
    sequence.current = params[:current].to_i if params[:current] != nil
    logger.info "Corriente "+sequence.current.to_s+" {"+sequence.is_filled.to_s+"}["+false.to_s+"]"
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
    next_model
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
	 render :action  => 'edit'
      else
	 new
	 render :action  => 'new'
      end
   end
  end
  
  def finalize
     sequence = get_sequence
     sequence.save
     logger.info "Return {"+sequence.return_controller+"}{"+sequence.return_action+"}"
     redirect_to :controller => sequence.return_controller, :action => sequence.return_action
  end
  
  def cancel
    redirect_to :controller => sequence.return_controller, :action => sequence.return_action
  end

end
