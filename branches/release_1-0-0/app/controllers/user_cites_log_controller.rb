class UserCitesLogController < SalvaController
  def initialize
    super
    @model = UserCitesLog
    @purge_msg = 'La información se ha borrado'
    @per_pages = 10
    @order_by = 'id'
  end

  def new
    render :action => 'list'
  end

  def edit
    redirect_to :action => 'show', :id => params[:id]
  end

end
