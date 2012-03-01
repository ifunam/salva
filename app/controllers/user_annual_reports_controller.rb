require File.join(Rails.root, 'lib/document', 'user_profile')
require File.join(Rails.root, 'lib/document/reporter', 'base')
class UserAnnualReportsController < ApplicationController
  layout 'user_resources'
  respond_to :html, :pdf

  def index
    respond_with(@documents = Document.annual_reports.search(:user_id_eq => current_user.id).paginate(:page => params[:page]||1, :per_page => 5))
  end

  def show
    authorize_document!
    @profile = UserProfile.find(current_user.id)
    @report_sections = Reporter::Base.find(build_query).all
    @remote_ip = request.remote_ip
    respond_to do |format|
      format.html
      format.pdf
    end
  end

  def deliver
    authorize_document!
    @document_type = Documenttype.annual_reports.active.first
    respond_with(@document = UserAnnualReport.create(:user_id => current_user.id, :year => params[:year],
                                                     :remote_ip=> request.remote_ip,
                                                     :document_type_id => @document_type.id))
  end

  private
  def build_query
    @year = params[:year]
    { :user_id_eq => current_user.id, :start_date => "#{@year}/01/01", :end_date => "#{@year}/12/31" }
  end

  def authorize_document!
    @document_type = Documenttype.annual_reports.active.first
    unless @document_type.year == params[:year] or
        Document.where(:user_id => current_user.id, :documenttype_id => @document_type.id).first.nil?
      authorize! :read, Document, :message => "Unable to read this document."
    end
  end
end
