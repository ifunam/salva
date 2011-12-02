require File.join(Rails.root, 'lib/document', 'user_profile')
class UserAnnualPlansController < ApplicationController
  layout 'user_resources'
  respond_to :html, :pdf

  def index
    respond_with(@documents = Document.annual_plans.search(:user_id_eq => current_user.id).paginate(:page => params[:page]||1, :per_page => 5))
  end

  def new
    @profile = UserProfile.find(current_user.id)
    respond_with(@annual_plan = AnnualPlan.new)
  end

  def create
    @documenttype = Documenttype.annual_plans.active.first
    params[:annual_plan].merge!(:user_id => current_user.id, :documenttype_id => @documenttype.id)
    respond_with(@annual_plan = AnnualPlan.create(params[:annual_plan]), :status => :created, :location => user_annual_plan_path(@annual_plan))
  end

  def show
    @annual_plan = AnnualPlan.find(params[:id])
    @profile = UserProfile.find(current_user.id)
    respond_to do |format|
      format.html
      format.pdf
    end
  end

  def deliver

  end
end