class UserResearchlineController < SalvaController
  def initialize
    super
    @model = Researchline
    @create_msg = 'La información se ha guardado'
    @update_msg = 'La información ha sido actualizada'
    @purge_msg = 'La información se ha borrado'
    @per_pages = 10
    @order_by = 'id'
  end
  
  def list
     @model = UserResearchline
     @primary_key = 'researchline_id'
     super
  end
  
  def new
    @model = UserResearchline
    super
  end  

  def create
    @model = UserResearchline
    super
  end  

  def purge
    UserResearchline.find(:first, :conditions => {:researchline_id => params[:id], :user_id => session[:user]}).destroy
    list
  end
  
  def purge_selected
    if  params[:item]
      params[:item].each { |id, contents|
        UserResearchline.find(:first, :conditions => {:researchline_id => id, :user_id => session[:user]}).destroy
      }
    end
    list
  end
end
