class PermissionController < SalvaController
  def initialize
    super
    @model = Permission
    @create_msg = 'La información se ha guardado'
    @update_msg = 'La información ha sido actualizada'
    @purge_msg = 'La información se ha borrado'
    @per_pages = 10
    @order_by = 'controller_id, roleingroup_id, action_id ASC'
  end

   def create
     setinput_xmlhttprequest if request.xml_http_request?
     @edit = @model.new(params[:edit])
     set_userid
     action_id = "{"+params[:edit][:action_id].join(',').to_s+"}"
     sql = "INSERT INTO permissions (roleingroup_id, controller_id, action_id) VALUES (#{params[:edit][:roleingroup_id]}, #{params[:edit][:controller_id]},'#{action_id}')"
     if ActiveRecord::Base.connection.execute(sql)
       flash[:notice] = @created_msg
       redirect_to :action => 'list'
     else
       logger.info "*** Algo esta mal <<wey>>, checalo! ***"
       logger.info @edit.errors.full_messages
       flash[:notice] = 'Hay errores al guardar esta información'
       render :action => 'new'
     end
   end
 
  def update   
    @edit = @model.find(params[:id])
    set_userid
    action_id = "{"+params[:edit][:action_id].join(',').to_s+"}"
    sql = "UPDATE permissions SET roleingroup_id = '#{params[:edit][:roleingroup_id]}', controller_id = '#{params[:edit][:controller_id]}', action_id = '#{action_id}' WHERE id = #{@edit.id}"
    if ActiveRecord::Base.connection.execute(sql)
      flash[:notice] = @update_msg
      redirect_to :action => 'list'
    else
    end
  end

end
