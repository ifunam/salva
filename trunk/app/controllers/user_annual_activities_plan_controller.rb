class  UserAnnualActivitiesPlanController < UserDocumentController
  def initialize
    @document_name = 'Plan anual de actividades '
    super 
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

  def send_document
    report_code = 'salva - plat. inf. curric. '+request.remote_ip+' '+Time.now.ctime
    @file = UserReport.new(@user.id).as_pdf(report_code)
    @filename =  @document_title.downcase.sub(/ /,'_')  + '.pdf'
    super
  end
end
