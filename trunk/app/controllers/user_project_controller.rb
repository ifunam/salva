class UserProjectController < SalvaController
  def initialize
    super
    @model = Project
    @create_msg = 'La información se ha guardado'
    @update_msg = 'La información ha sido actualizada'
    @purge_msg = 'La información se ha borrado'
    @per_pages = 10
    @list = { :conditions => '(roleinproject_id < 5 OR roleinproject_id = 8)' }
  end
  
  def list
    @model = UserProject
    @primary_key = 'project_id'
    super
  end
  
  def create
    super
    @user_record = UserProject.new({:project_id => @edit.id, :user_id => session[:user], :roleinproject_id => params[:edit][:roleinproject_id] })
    @user_record.moduser_id =  session[:user]
    @user_record.save if @user_record.valid?
  end
  
  def edit
    super
    @edit.roleinproject_id = UserProject.find(:first, :conditions => {:project_id => params[:id], :user_id => session[:user]}).roleinproject_id
  end

  def update
    super
    @roleinproject = UserProject.find(:first, :conditions => {:project_id => params[:id], :user_id => session[:user]})
    @roleinproject.roleinproject_id = params[:edit][:roleinproject_id].to_i
    @roleinproject.save if @roleinproject.valid?
  end

  def purge
    UserProject.find(:first, :conditions => {:project_id => params[:id], :user_id => session[:user]}).destroy
    list
  end

  def purge_selected
    if  params[:item]
      params[:item].each { |id, contents|
        UserProject.find(:first, :conditions => {:project_id => id, :user_id => session[:user]}).destroy
      }
    end
    list
  end
end
