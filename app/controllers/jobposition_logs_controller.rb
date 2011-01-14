class JobpositionLogsController < ApplicationController
  layout 'user_resources'
  def show
    respond_with(@jobposition_log = JobpositionLog.find_by_user_id(current_user.id))
  end

  def edit
    respond_with(@jobposition_log = JobpositionLog.find_by_user_id(current_user.id))
  end

  def update
    @jobposition_log = JobpositionLog.find_by_user_id(current_user.id)
    @jobposition_log.modified_by_id = current_user.id
    @jobposition_log.update_attributes(params[:jobposition_log])
    respond_with(@jobposition_log, :status => :updated, :location => jobposition_log_path)
  end
end
