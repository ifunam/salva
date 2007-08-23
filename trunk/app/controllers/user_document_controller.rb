require 'salva'
class UserDocumentController < ApplicationController
  include Salva

  def index
     list
  end

  def list
    @pages, @collection = paginate :user_documents, :per_page => 10,
    :conditions => "user_id = #{session[:user]} AND document_id = #{@document}"
    render :action => 'list'
  end

  def send_document
    record = UserDocument.new
    record.ip_address = request.env['REMOTE_ADDR']
    record.document_id = @document
    record.file = StringIO.new(@file).read
    record.filename = @filename
    record.content_type = @content_type
    record.moduser_id = session[:user]
    record.user_id = session[:user]
    # Look for conditional to  publish  the document
    record.status = 't'
    if record.save
      mail_options=  {
        :recipients => User.find(session[:user]).email,
        :subject =>   @notification_subject,
        :body => { :institution => get_myinstitution.name },
        :attachment => { :file => record.file, :content_type => record.content_type }
      }
      @notifier.deliver_notification_of_delivery(mail_options)
      flash[:notice] = @sent_msg
      redirect_to :action => 'list'
    else
      flash[:notice] = @nosent_msg
      redirect_to :action => 'list'
    end
  end

  def show
    @record = UserDocument.find(params[:id])
    @headers['Cache-Control'] = 'no-cache, must-revalidate'
    if  @record.file and  !@record.filename.nil? and !@record.content_type.nil? then
      send_data(@record.file, :filename => @record.filename, :type => "application/"+@record.content_type.to_s, :disposition => "inline")
    else
      redirect_to "/images/comodin.png"
    end
  end

end
