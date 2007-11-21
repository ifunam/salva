require 'redcloth'
class UserAnnualActivitiesPlanController < UserDocumentController
  def initialize
    @document_name = 'Plan anual de actividades'
    super
  end

  def new
    @report = UserReport.new(session[:user])
    @profile_html = @report.profile_as_html
    if File.exists?(user_filename)
      redirect_to :action => 'preview'
    else
      render :action => 'new'
    end
  end

  def create
    if !params[:edit][:plan].nil? and !params[:edit][:plan].blank?
      file = File.new(user_filename, "w")
      file.write params[:edit][:plan]
      file.write "\n"
      file.close
      if params[:commit] == 'Vista previa' or params[:commit] == 'Guardar'
        redirect_to :action => :preview
      else
        redirect_to :action => :send_document
      end
    else
      flash[:notice] = "Por favor capture los datos de su #{@documenttitle}"
      redirect_to :action => 'new'
    end
  end

  def preview
    if File.exists?(user_filename)
      file = File.new(user_filename, "r")
      textile = file.read
      file.close
      @report = UserReport.new(session[:user])
      @profile_html = @report.profile_as_html
      @html_plan = RedCloth.new(textile).to_html(:textile)
      @plan = textile
      render :action => 'preview'
    else
      flash[:notice] = "Por favor capture los datos de su #{@documenttitle}"
      redirect_to :action => 'new'
    end
  end

  def send_document
    report_code = 'salva - plat. inf. curric. '+request.remote_ip+' '+Time.now.ctime
    if File.exists?(user_filename)
      textile = File.new(user_filename, "r")
      @file = UserReport.new(@user.id).as_pdf(report_code)
      @filename = filename
      super
    else
      flash[:notice] = "Por favor capture los datos de su #{@documenttitle}"
      redirect_to :action => 'new'
    end
  end

  private
  def user_filename
    RAILS_ROOT + '/tmp/' + session[:user].to_s + '_' + filename('textile')
  end
end
