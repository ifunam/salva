require File.join(Rails.root, 'lib/document', 'user_profile')
require File.join(Rails.root, 'lib/document/reporter', 'base')
class UserAnnualReportsController < ApplicationController
  layout 'user_resources'
  respond_to :html, :pdf

  def index
    respond_with(@documents = Document.annual_reports.search(:user_id_eq => current_user.id).page(params[:page]||1).per(5))
  end

  def new
    authorize_document!
    find_profile
    respond_with(@annual_report = AnnualReport.new)
  end

  def create
    authorize_document!
    find_profile
    params[:annual_report].merge!(:user_id => current_user.id, :documenttype_id => @document_type.id, :delivered => false)
    @annual_report = AnnualReport.new(params[:annual_report])
    if @annual_report.save
      respond_with(@annual_report, :status => :created, :location => user_annual_report_path(@annual_report))
    else
      respond_with(@annual_report, :status => :unprocessable_entity) do |format|
        format.html { render :action => :new }
      end
    end
  end

  def edit
    authorize_document!
    find_document_and_profile
    respond_to do |format|
      format.html
    end
  end

  def update
    authorize_document!
    find_document_and_profile
    if @annual_report.update_attributes(params[:annual_report].merge(:delivered => false))
      respond_with(@annual_report, :status => :updated, :location => user_annual_report_path(@annual_report))
    else
      respond_with(@annual_report, :status => :unprocessable_entity) do |format|
        format.html { render :action => :edit}
      end
    end
  end

  def show
    authorize_document!
    find_document_and_profile
    respond_to do |format|
      format.html
      format.pdf
    end
  end

  def deliver
    authorize_document!
    find_document_and_profile
    respond_with(@document = UserAnnualReport.create(:user_id => current_user.id, :year => @annual_report.documenttype.year,
                                                     :remote_ip=> request.remote_ip,
                                                     :document_type_id => @document_type.id,
                                                     :annual_report_id => @annual_report.id))
  end

  private
  def build_query
    @year ||= params[:year]
    { :user_id_eq => current_user.id, :start_date => "#{@year}/01/01", :end_date => "#{@year}/12/31" }
  end

  def find_document_and_profile
    find_document
    find_profile
  end

  def find_document
    @annual_report = AnnualReport.where(:id => params[:id], :user_id => current_user.id).first
    @year = @annual_report.documenttype.year unless @annual_report.nil?
    @report_sections = Reporter::Base.find(build_query).all
  end

  def find_profile
    @document_type = Documenttype.annual_reports.active.first
    @profile = UserProfile.find(current_user.id)
    @remote_ip = request.remote_ip
  end

  def authorize_document!
    @document_type = Documenttype.annual_reports.active.first
    unless @document_type.year == params[:year] or
        Document.where(:user_id => current_user.id, :documenttype_id => @document_type.id).first.nil?
      authorize! :read, Document, :message => "Unable to read this document."
    end
  end
end
