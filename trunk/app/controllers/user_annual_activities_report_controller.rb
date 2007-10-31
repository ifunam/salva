 class  UserAnnualActivitiesReportController < UserDocumentController
  layout 'user_document_handling'
  def initialize
    @document_id = 1
    @document = 'Informe anual de actividades - 2007'
    @request_for_approval_subject = "Solicitud de aprobación de #{@document}"
    @notification_subject = @document
    @sent_msg = "Su #{@document} ha sido enviado!"
    @nosent_msg = "Su #{@document} NO ha sido enviado!"
  end

  def preview
    @report = UserReport.new(session[:user])
    @html =  @report.as_html
    render :action => 'preview'
  end

  def send_document
    @resume = Resume.new(session[:user])
    @file = Resume.new(session[:user]).as_pdf
    @filename =  'informe_anual_de_actividades_2007.pdf'
    @content_type = 'application/pdf'
    super
  end
end
