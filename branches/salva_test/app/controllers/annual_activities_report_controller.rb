class AnnualActivitiesReportController < ApplicationController

  def index
    list
  end

  def list
    @conditions = "user_id = #{session[:user]}"
    @pages, @collection = paginate :user_documents, :conditions => @conditions,  :per_page => 10
    render :action => 'list'
  end

  def preview
    @resume = Resume.new(session[:user])
    @html =  @resume.as_html
    render :action => 'preview'
  end

  def send_report
    @resume = AnnualActivitiesReport.new(session[:user])
    @document = UserDocument.new({ :user_id => session[:user],    :is_published => 't',  :date_published => '2007-10-10',
                                   :document => StringIO.new(@resume.as_pdf).read.to_blob, :filename => 'annual_activities_report.pdf',
                                   :content_type => 'pdf', :ip_address => @request.env['REMOTE_ADDR']})
    if @document.save
      flash[:notice] = "Su informe anual ha sido enviado!"
       redirect_to :action => 'list'
    else
       flash[:notice] = "Su informe NO fue enviado!"
      redirect_to :action => 'preview'
     end
  end

   def show
     @document = @model.find(params[:id])
     send_data(@document.document, :filename => @document.filename, :type => "application/"+@document.content_type.to_s, :disposition => "inline")
  end
end
