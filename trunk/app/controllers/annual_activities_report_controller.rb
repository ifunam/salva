class AnnualActivitiesReportController < UserDocumentController
  def initialize
    @sent_msg = "Su informe ha sido enviado!"
    @nosent_msg = "Su informe NO ha sido enviado!"
    @notification_subject = 'Notificación de envío del informe anual de actividades'
    @document = 1 #'Informe anual de actividades'
    @notifier = AnnualActivitiesReportNotifier
  end

  def index
     list
  end

  def preview
    @resume = Resume.new(session[:user])
    @html =  @resume.as_html
    render :action => 'preview'
  end

  def send_report
    @resume = Resume.new(session[:user])
    render :action => :send_document, :edit => {
      :file => @resume.as_pdf,
      :filename => 'annual_activities_report.pdf',
      :content_type => 'pdf'}
  end

end
