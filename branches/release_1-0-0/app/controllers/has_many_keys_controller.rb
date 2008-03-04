# Has and Belongs to Many Controller
class HasManyKeysController < SalvaController

  def create
    @edit = ModelHasManyKeys(@model, params[:edit], @group_keys)
    if @edit.save
      flash[:notice] = @create_msg
      redirect_to :action => 'list'
    else
      logger.info "*** Algo esta mal <<wey>>, checalo! ***"
      logger.info @edit.errors.full_messages
      flash[:notice] = 'Hay errores al guardar esta información'
      render :action => 'new'
    end
  end
end
