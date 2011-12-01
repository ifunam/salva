require File.join(Rails.root, 'lib/document', 'user_profile')
require File.join(Rails.root, 'lib/document/reporter', 'base')
class UserAnnualReportsController < ApplicationController
  layout 'user_resources'
  respond_to :html
  #respond_to :pdf, :html, :only => :show

  def index
    respond_with(@documents = Document.annual_reports.search(:user_id_eq => current_user.id).paginate(:page => params[:page]||1, :per_page => 5))
  end

  def show
    @year = params[:year]
    @profile = UserProfile.find(current_user.id)
    @annual_report = Reporter::Base.new(:user_id_eq => current_user.id, :start_date => "#{@year}/01/01", :end_date => "#{@year}/12/31")
    respond_to do |format|
      format.html
      format.pdf
    end
  end
end
