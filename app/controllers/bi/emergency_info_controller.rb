class Bi::EmergencyInfoController < Bi::ApplicationController
  def index
    @collections = Person.all_active(1)
    @collections
    respond_to do |format|
      format.html {render layout: 'emergency_info'}
      format.csv { render text: Person.to_csv }
      format.json do
        render :json => @collections.as_json
      end
    end
  end

end
