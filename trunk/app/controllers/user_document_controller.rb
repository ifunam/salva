require 'salva'
class UserDocumentController < ApplicationController
  include Salva

  def initialize
    @sent_msg = "Su documento ha sido enviado!"
    @nosent_msg = "Su documento NO ha sido enviado!"
    @notification_subject = 'Notificación de envío del informe anual de actividades'
    @document = 1 #'Informe anual de actividades'
    @notifier = AnnualActivitiesReportNotifier
  end

  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :send ], :redirect_to => { :action => :list }

  def list
    @pages, @collection = paginate :user_documents, :per_page => 10,
    :conditions => "user_id = #{session[:user]} AND document_id = #{@document}"
  end

  def new
    @edit = UserDocument.new
  end

  def send_document
    record = UserDocument.new(params[:edit])
    record.file = params[:edit]['file'].read
    record.filename = base_part_of(params[:edit]['file'].original_filename)
    record.content_type = 'application/'+base_part_of(params[:edit]['file'].content_type.chomp)
    record.moduser_id = session[:user] if record.has_attribute?('moduser_id')
    record.user_id = session[:user] if record.has_attribute?('user_id')
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

  def base_part_of(file_name)
    name = File.basename(file_name)
    name.gsub(/[^\w._-]/, ' ' )
  end
end
