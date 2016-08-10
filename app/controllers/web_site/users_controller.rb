class WebSite::UsersController < WebSite::ApplicationController
  respond_to :js

  def index
    @collection = User.all_except([1,2,397,573,475,497])
    respond_to do |format|
      format.json do
        mi_json = render :json => { :types=>{:Persona=>{:pluralLabel=>:Personas}},
                  :properties=>{:url=>{:valueType=>:url}, :photo=>{:valueType=>:url}},
                  :items=>@collection.as_json }
      end
    end
  end

end
