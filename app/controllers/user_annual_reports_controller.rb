require File.join(Rails.root, 'lib/document', 'user_profile')
require File.join(Rails.root, 'lib/document/reporter', 'base')
class UserAnnualReportsController < ApplicationController
  layout 'user_resources'
  respond_to :html

  def index
    respond_with(@documents = Document.annual_reports.search(:user_id_eq => current_user.id).paginate(:page => params[:page]||1, :per_page => 5))
  end

  def show
    @profile = UserProfile.find(current_user.id)
    @report_sections = Reporter::Base.find(build_query).all
    @remote_ip = request.remote_ip
    respond_to do |format|
      format.html
      format.pdf
    end
  end

  def deliver
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
end
