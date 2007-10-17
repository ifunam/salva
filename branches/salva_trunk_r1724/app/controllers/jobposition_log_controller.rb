class JobpositionLogController < SalvaController
  def initialize
    super
    @model = JobpositionLog
    @create_msg = 'La información se ha guardado'
    @update_msg = 'La información ha sido actualizada'
    @purge_msg = 'La información se ha borrado'
    @per_pages = 10
    @order_by = 'id'
  end

  def list
    @jobposition_log = JobpositionLog.find(:first, :conditions => [ 'user_id = ?', session[:user]])
    if @jobposition_log.nil?
     render :action => 'new'
    else
      redirect_to  :action => 'show', :id => @jobposition_log.id
    end
  end
end
