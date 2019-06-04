class WebSite::KaLabsController < WebSite::ApplicationController
  respond_to :js

  def index
    unless request.remote_ip.to_s.match(/132.248.(209|7).\d+/).nil? or params[:id].nil?
      id = params[:id]
      @collection = KnowledgeArea.find(id).my_labs
      respond_to do |format|
        format.json {
            render :json => @collection.to_json
        }
      end
    else
      render :text => 'Not Found', :status => '404'
    end
  end
end
