require File.join(Rails.root, 'lib/document', 'user_profile')
class UserAnnualPlansController < ApplicationController
  layout 'user_resources'
  respond_to :html, :pdf

  def index
    respond_with(@documents = Document.annual_plans.search(:user_id_eq => current_user.id).page(params[:page]||1).per(5))
  end

  def new
    authorize_document!
    @profile = UserProfile.find(current_user.id)
    respond_with(@annual_plan = AnnualPlan.new)
  end

  def create
    authorize_document!
    @document_type = Documenttype.annual_plans.active.first
    params[:annual_plan].merge!(:user_id => current_user.id, :documenttype_id => @document_type.id)
    respond_with(@annual_plan = AnnualPlan.create(params[:annual_plan]), :status => :created, :location => user_annual_plan_path(@annual_plan))
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
    respond_with(@annual_plan.update_attributes(params[:annual_plan]), :location =>user_annual_plan_path(@annual_plan))
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
    respond_with(@document = UserAnnualPlan.create(:user_id => current_user.id, :year => @year,
                                                   :remote_ip=> request.remote_ip,
                                                   :annual_plan_id => @annual_plan.id))
  end

  def find_document_and_profile
    @document_type = Documenttype.annual_plans.active.first
    @annual_plan = AnnualPlan.find(params[:id])
    @year = @annual_plan.documenttype.year
    @profile = UserProfile.find(current_user.id)
    @remote_ip = request.remote_ip
  end

  def authorize_document!
    @document_type = Documenttype.annual_plans.active.first
    unless @document_type.year == params[:year] or
      Document.where(:user_id => current_user.id, :documenttype_id => @document_type.id).first.nil?
        authorize! :read, Document, :message => "Unable to read this document."
    end
  end
end