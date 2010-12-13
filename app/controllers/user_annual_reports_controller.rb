require 'lib/document/user_annual_report'
class UserAnnualReportsController < ApplicationController
  layout 'user_resources'
  respond_to :html
  respond_to :pdf, :only => :show
  def index
    respond_with(@documents = Document.annual_reports.search(:user_id_eq => current_user.id).all)
  end

  def show
    respond_with(@report = UserAnnualReport::Base.find(params[:id], params[:year])) do |format|
      format.pdf do 
        send_data @report.to_pdf, :filename => @report.build.profile.login + '_' + params[:year] + '.pdf',
                  :type => 'application/pdf'
      end
    end
  end

  def send_report
    @documenttype = Documenttype.annual_reports.active.first
    respond_with(@document = Document.create(:user_id => current_user.id,
                                            :approved_by_id => current_user.user_incharge_id,
                                            :documenttype_id => @documenttype.id, 
                                            :ip_address => request.remote_ip,
                                            :registered_by_id => current_user.id))
  end
end
