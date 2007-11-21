class  UserAnnualActivitiesReportController < UserDocumentController
  def initialize
    @document_name = 'Informe anual de actividades'
    super
  end

  def preview
    @report = UserReport.new(@user.id)
    @html =  @report.as_html
    render :action => 'preview'
  end

  def preview_pdf
    @report = UserReport.new(@user.id)
    # Codigo unico de emision del reporte anual
    report_code = 'salva - plat. inf. curric. '+request.remote_ip+' '+Time.now.ctime
    send_data @report.as_pdf(report_code), :type => "application/pdf", :filename => @document_title.downcase.sub(/ /,'_')  + '.pdf'
  end

  def send_document
    report_code = 'salva - plat. inf. curric. '+request.remote_ip+' '+Time.now.ctime
    @file = UserReport.new(@user.id).as_pdf(report_code)
    @filename =  @document_title.downcase.sub(/ /,'_')  + '.pdf'
    super
  end
end
