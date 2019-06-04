class EmergencyInfoController < ApplicationController
  def index
    @collections = Person.all_active(1)
    @collections
    respond_to do |format|
      format.html {render layout: 'emergency_info'}
      format.csv { render text: Person.to_csv } if current_user.admin? or current_user.librarian?
    end
  end
end
