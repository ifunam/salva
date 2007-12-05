class UserCiteController < SalvaController
  def initialize
    super
    @model = UserCite
    @create_msg = 'La información se ha guardado'
    @update_msg = 'La información ha sido actualizada'
    @purge_msg = 'La información se ha borrado'
    @per_pages = 10
    @order_by = 'id'
  end

  def list
    @cite = UserCite.find(:first, :conditions => [ 'user_id = ?', session[:user]])
    if @cite.nil?
      render :action => 'new'
    else
      redirect_to  :action => 'show', :id => @cite.id
    end
  end

  # Cancel lleva a list, lo que no funciona en este caso
  def cancel
    @cite = UserCite.find(:first, :conditions => [ 'user_id = ?', session[:user]])
    if @cite.nil?
      redirect_to :controller => 'navigation' 
    else
      super
    end
  end

end
