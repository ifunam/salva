require 'salva'
class UserDocumentController < ApplicationController
  include Salva

  def index
     list
  end

  def list
    @pages, @collection = UserDocument.paginate :page => 1, :per_page => 10,
    :conditions => "user_id = #{session[:user]} AND document_id = #{@document}"
    render :action => 'list'
  end

  def send_document
    @user = User.find(session[:user])
    record = UserDocument.new
    record.ip_address = request.env['REMOTE_ADDR']
    record.document_id = @document
    record.file = StringIO.new(@file).read
    record.filename  = @filename
    record.content_type = @content_type
    record.moduser_id = @user.id
    record.user_id = @user.id
    record.user_incharge_id = @user.user_incharge_id if @user.has_user_incharge?
    if record.save
      mail =  {
        :body => { :institution => get_myinstitution.name },
      }
      if @user.has_user_incharge?
        mail[:recipients] = [@user.email]
        mail[:subject] = @request_for_approval_subject
        mail[:attachment] = { :file => record.file,  :content_type => record.content_type, :filename => @filename }
        UserDocumentNotifier.deliver_request_for_approval(mail)

        mail[:recipients] = [@user.user_incharge.email]
        mail[:subject] = @request_for_approval_subject
        mail.delete(:attachment)
        UserDocumentNotifier.deliver_request_for_approval_notification(mail)
      else
        mail[:recipients] = @user.email
        mail[:subject] = @notification_subject
        UserDocumentNotifier.deliver_notification_of_delivery(mail)
      end
      flash[:notice] = @sent_msg
      redirect_to :action => 'list'
    else
      flash[:notice] = @nosent_msg
      redirect_to :action => 'list' # Redirect to another action
    end
  end

  def show
    record = UserDocument.find(params[:id])
    response.headers['Cache-Control'] = 'no-cache, must-revalidate'
    if  record.file and  !record.filename.nil? and !record.content_type.nil? then
      send_data(record.file, :filename => record.filename, :type => "application/"+record.content_type.to_s, :disposition => "inline")
    else
      redirect_to "/images/comodin.png"
    end
  end

end
