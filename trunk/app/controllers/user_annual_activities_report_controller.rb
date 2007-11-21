class  UserAnnualActivitiesReportController < UserDocumentController
  helper :textile
  def initialize
    @document_name = 'Informe anual de actividades'
    super
  end

  def preview
    @report = UserReport.new(@user.id)
    @data =  @report.as_array
    render :action => 'preview'
  end

  def preview_pdf
    @report = UserReport.new(@user.id)
    # Codigo unico de emision del reporte anual
    report_code = 'salva - plat. inf. curric. '+request.remote_ip+' '+Time.now.ctime
    send_data @report.as_pdf(report_code), :type => "application/pdf", :filename => filename
  end

  def send_document
    report_code = 'salva - plat. inf. curric. '+request.remote_ip+' '+Time.now.ctime
    @file = UserReport.new(@user.id).as_pdf(report_code)
    @filename = filename
    super
  end
end
