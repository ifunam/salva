class AnnualActivitiesReportController < UserDocumentController
  def initialize
    @sent_msg = "Su informe ha sido enviado!"
    @nosent_msg = "Su informe NO ha sido enviado!"
    @notification_subject = 'Notificación de envío del informe anual de actividades'
    @document = 1 #'Informe anual de actividades'
    @notifier = AnnualActivitiesReportNotifier
    @file = nil
    @filename = nil
    @content_type = nil
  end

  def preview
    @resume = Resume.new(session[:user])
    @html =  @resume.as_html
    render :action => 'preview'
  end

  def  send_document
    @file = Resume.new(session[:user]).as_pdf
    @filename =  'annual_activities_report.pdf'
    @content_type = 'application/pdf'
    super
  end
end
