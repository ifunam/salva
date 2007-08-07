require 'stackcontroller'
class WizardController < ApplicationController
  include Stackcontroller
  skip_before_filter :rbac_required
  model :model_sequence

  def index
    render :action => 'new'
  end

  def new
    sequence = get_sequence
    logger.info "Secuencia "+sequence.flat_sequence.to_s
    if sequence.is_composite
      composite = sequence.get_model
      @list = composite.flat_sequence
      render :action => 'new_multi'
    else
      @edit = sequence.get_model
    end
  end

  def edit
    sequence = get_sequence
    sequence.set_current_by_element((params[:current] != nil) ? params[:current].to_i: 0)
    if sequence.is_composite
      composite = sequence.get_model
      @list = composite.flat_sequence
      render :action => 'edit_multi'
    else
      @edit = sequence.get_model
    end
  end

  def show
    sequence = get_sequence
    @list = sequence.flat_sequence
    @set_prev = !sequence.is_first
    @set_next = !sequence.is_last
    logger.info "listsecuencia "+@list.to_s+", "+@list.length.to_s
#    if sequence.is_sequence(sequence.sequence[0]) then
 #     logger.info "showsecuencia  "+sequence.sequence[0].sequence[0].id.to_s+","+sequence.sequence[0].sequence[1].id.to_s+";"+@list[0].id.to_s+";"+@list[1].id.to_s
  #  end
  end

  def create
    sequence = get_sequence
    if !sequence.is_composite then
      model = get_sequence.get_model
      params[:edit].each { |key, value|
        model[key.to_sym] = value
      }
      if params[:stack] != nil
        redirect_to options_for_next_controller(sequence, controller_name, 'new')
      else
        if model.valid? then
          next_page
        else
          @edit = sequence.get_model
          render :action => 'edit'
        end
      end
    else
      create_composite
    end
  end

  def create_composite
    sequence = get_sequence
    composite =  sequence.get_model
    models = composite.flat_sequence
    params[:edit].each { |attr, value|
      models.each { | model |
        if model.has_attribute? attr
          model[attr.to_sym] = value
        end
      }
    }

    if params[:stack] != nil
      redirect_to options_for_next_controller(sequence, controller_name, 'new')
    else
      next_page
    end
  end

  def update
    sequence = get_sequence
    mymodel = sequence.get_model

    if (sequence.is_composite) then
      models = mymodel.flat_sequence
      params[:edit].each { |attr, value|
        models.each { | model |
          if model.has_attribute? attr
            model[attr.to_sym] = value
          end
        }
    }
    else
      params[:edit].each { |key, value|
        mymodel[key.to_sym] = value
      }
    end

    if sequence.is_filled
      redirect_to :action  => 'show'
    else
      next_page
    end
  end

  def previous_page
    sequence = get_sequence
    sequence.previous_component
    redirect_to :action  => 'edit'
  end

  def next_page
    sequence = get_sequence
    if sequence.is_last
      redirect_to :action  => 'show'
    else
      logger.info "Nextpagein "+sequence.current.to_s
      sequence.next_component
      logger.info "Nextpageout "+sequence.current.to_s
      if sequence.is_filled
        redirect_to :action  => 'edit'
      else
        redirect_to :action  => 'new'
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

  def update_multi
     sequence = get_sequence
     sequence.sequence.each { |model|
        params[:edit].each { |key, value|
           model[key.to_sym] = value if model[key.to_sym] != nil
        }
     }
     redirect_to :action  => 'show'
  end

  alias_method :back, :cancel

  private
  def get_sequence
     session[:sequence]
  end

end
