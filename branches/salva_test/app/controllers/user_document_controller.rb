require 'salva'
class UserDocumentController < ApplicationController
  include Salva

  def index
     list
  end

  def list
    @collection = UserDocument.paginate :page => 1, :per_page => 10,
    :conditions => "user_id = #{session[:user]} AND document_id = #{@document_id}"
    render :action => 'list'
  end

  def send_document
    @user = User.find(session[:user])
    record = UserDocument.new
    record.ip_address = request.env['REMOTE_ADDR']
    record.document_id = @document_id
    record.file = StringIO.new(@file).read
    record.filename  = @filename
    record.content_type = @content_type
    record.moduser_id = @user.id
    record.user_id = @user.id
    record.user_incharge_id = @user.user_incharge_id if @user.has_user_incharge?
    if record.save
      mail =  {
        :body => { :institution => get_myinstitution.name },
        :attachment => { :file => record.file,  :content_type => record.content_type, :filename => @filename }
      }
      if @user.has_user_incharge?
        mail[:recipients] = [@user.email]
        mail[:subject] = @request_for_approval_subject
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
      send_data(record.file, :filename => record.filename, :type => record.content_type, :disposition => "inline")
    else
      send_file RAILS_ROOT + "/public/images/comodin.png", :type => 'image/png', :disposition => 'inline'
    end
  end

end
