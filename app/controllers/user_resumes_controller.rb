require File.join(Rails.root, 'lib/document', 'user_profile')
require File.join(Rails.root, 'lib/document/reporter', 'base')
class UserResumesController < ApplicationController
  layout 'user_resources'
  respond_to :html, :pdf, :rtf

  def show
    @profile = UserProfile.find(current_user.id)
    @report_sections = Reporter::Base.find(:user_id_eq => current_user.id).all
    @remote_ip = request.remote_ip
    respond_to do |format|
      format.html
      format.pdf
      format.rtf
    end
  end
end
