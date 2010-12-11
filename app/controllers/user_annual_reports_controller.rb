class UserAnnualReportsController < ApplicationController
  layout 'user_resources'
  respond_to :html
  respond_to :pdf, :only => :preview
  def index
    respond_with(@documents = Document.annual_reports.search(:user_id_eq => current_user.id).all)
  end

  def show
  end

  def preview
  end

  def send_report
  end
end
