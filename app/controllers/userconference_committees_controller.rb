class UserconferenceCommitteesController < MultiSalvaController
  def initialize
    super
    @model = Userconference
    @views = [ :conference,  :userconference_committee]
    @models= [  Userconference, Conference ]
    @create_msg = 'La información se ha guardado'
    @update_msg = 'La información ha sido actualizada'
    @purge_msg = 'La información se ha borrado'
    @per_pages = 10
    @order_by = 'id'
    @list = { :include => [:roleinconference], :conditions => "roleinconferences.name != 'Asistente'  AND Userconferences.roleinconference_id = roleinconferences.id"}
  end

 #  def list
#      @model = Userconference
#      @primary_key = 'conference_id'
#      super
#    end

#    def create
#      super
#      @user_record = Userconference.new({:conference_id => @edit.id, :user_id => session[:user], :roleinconference_id => params[:edit][:roleinconference_id] })
#      @user_record.moduser_id =  session[:user]
#      @user_record.save if @user_record.valid?
#    end

#    def edit
#      super
#      @edit.roleinconference_id = Userconference.find(:first, :conditions => {:conference_id => params[:id], :user_id => session[:user]}).roleinconference_id
#    end

#    def update
#      super
#      @roleinconference = Userconference.find(:first, :conditions => {:conference_id => params[:id], :user_id => session[:user]})
#      @roleinconference.roleinconference_id = params[:edit][:roleinconference_id].to_i
#      @roleinconference.save if @roleinconference.valid?
#    end

#    def purge
#      Userconference.find(:first, :conditions => {:conference_id => params[:id], :user_id => session[:user]}).destroy
#      list
#    end

#    def purge_selected
#      if  params[:item]
#        params[:item].each { |id, contents|
#          Userconference.find(:first, :conditions => {:conference_id => id, :user_id => session[:user]}).destroy
#        }
#      end
#      list
#    end
end
