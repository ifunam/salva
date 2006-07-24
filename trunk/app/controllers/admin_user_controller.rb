class AdminUserController < SalvaController
  helper :user

  def initialize
    super
    @model = User
    @create_msg = 'El usuario se ha guardado'
    @update_msg = 'El usuario se ha actualizado'
    @purge_msg = 'El usuario se ha borrado'
    @per_pages = 10
    @order_by = 'id'
  end

  def index
    list
  end
  
  def list
      @user_pages, @users = paginate :user, :per_page => 10
  end
  
end
