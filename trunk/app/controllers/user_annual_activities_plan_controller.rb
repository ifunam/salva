class  UserAnnualActivitiesPlanController < UserDocumentController
  def initialize
    document_name = 'Plan anual de actividades'
    @documenttype = Documenttype.find_by_name(document_name)
    super if !@documenttype.nil? # This will initialize the variables: @document, @document_title and @document_id, see initialize method at user_document_controller.
  end

  def new
    @report = UserReport.new(session[:user])
    @profile_html = @report.profile_as_html
    render :action => 'new'
  end
  
  def create
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
