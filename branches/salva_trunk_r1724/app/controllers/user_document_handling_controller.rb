 require 'salva'
class UserDocumentHandlingController < ApplicationController
  include Salva
  def index
    list
  end

  def list
    @collection  = []
    Document.find(:all, :conditions => "title LIKE '%200%'").each do |doc|
      @collection << {
        :title => doc.documenttype.name+'  '+ doc.title,
        :records => UserDocument.find(:all,   :conditions =>"document_id = #{doc.id} AND user_incharge_id = #{session[:user] }")
      }
    end
    render :action => "list"
  end

  def show
    @record = UserDocument.find(params[:id])
    send_data(@record.file, :filename => @record.filename,
              :type => "application/"+@record.content_type.to_s,
              :disposition => "attachment")
  end

  def approve
    @record = UserDocument.find(params[:id])
    @record.status = true
    @record.save
    UserDocumentNotifier.deliver_approval_notification({
                                                         :recipients => [ @record.user.email, User.find(session[:user]).email ],
                                                         :subject => 'Notificación de aprobación',
                                                         :body => { :institution => get_myinstitution.name, :document => @record.document.documenttype.name + ' ' + @record.document.title.strip },
                                                         :attachment => { :file => @record.file,  :content_type => @record.content_type }
                                                       })
    flash[:notice] = 'El documento ha sido aprobado'
    redirect_to :action => 'list'
  end

  def form_deny
     @record = UserDocument.find(params[:id])
    render :action => 'form_deny'
  end

  def comments
    @record = UserDocument.find(params[:id])
    render :action => 'comments'
  end

  def deny
    @record = UserDocument.find(params[:id])
    UserDocumentNotifier.deliver_deny_notification({
                                                     :recipients => [ @record.user.email, User.find(session[:user]).email ],
                                                     :subject => 'Documento no aprobado',
                                                     :body => {
                                                       :institution => get_myinstitution.name,
                                                       :document => @record.document.documenttype.name + ' ' + @record.document.title.strip,
                                                       :message => params[:edit][:message]
                                                     },
                                                     :attachment => { :file => @record.file,  :content_type => @record.content_type }
                                                   })
    @record.destroy
    flash[:notice] = 'El documento no ha sido aprobado'
    redirect_to :action => 'list'
  end
end
