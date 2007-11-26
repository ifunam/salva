require 'redcloth'
class UserAnnualActivitiesPlanController < UserDocumentController
  helper :textile

  def initialize
    @document_name = 'Plan anual de actividades'
    super
  end

  def new
    @report = UserReport.new(session[:user])
    @profile = @report.profile_as_hash
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
      redirect_to :action => :preview if params[:commit] == 'Vista previa' or params[:commit] == 'Guardar'
    else
      flash[:notice] = "Por favor capture los datos de su #{@document_title}"
      redirect_to :action => 'new'
    end
  end

  def preview
    if File.exists?(user_filename)
      file = File.new(user_filename, "r")
      textile = file.read
      file.close
      @report = UserReport.new(session[:user])
      @profile = @report.profile_as_hash
      @html_plan = RedCloth.new(textile).to_html(:textile)
      @plan = textile
      render :action => 'preview'
    else
      flash[:notice] = "Por favor capture los datos de su #{@document_title}"
      redirect_to :action => 'new'
    end
  end
  
    def preview_pdf
      if File.exists?(user_filename)
        send_data generate_pdf, :type => "application/pdf", :filename => filename
      else
        flash[:notice] = "Por favor capture los datos de su #{@document_title}"
        redirect_to :action => 'new'
      end
    end

  def send_document
    if File.exists?(user_filename)
      @file = generate_pdf
      @filename = filename
      super
    else
      flash[:notice] = "Por favor capture los datos de su #{@document_title}"
      redirect_to :action => 'new'
    end
  end

  private
  def user_filename
    RAILS_ROOT + '/tmp/' + session[:user].to_s + '_' + filename('textile')
  end

  def generate_pdf
    file = File.new(user_filename, "r")
    textile = file.read
    file.close
    @report = UserReport.new(session[:user])
    @pdf = UserReportPdfTransformer.new(@document_title)
    @pdf.report_code report_code
    @pdf.add_data [@report.profile_as_hash]
    @pdf.add_textile textile
    @pdf.render
 end
end
