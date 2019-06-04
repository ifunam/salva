class Bi::KnowledgeFieldsController < Bi::ApplicationController

  def index
    @charts = Grapher.knowledge_fields(params)

    respond_to do |format|
      format.html { render :layout => "bi" }
      format.xml
      format.json do
        mi_json = render :json => { :types=>{:Articulo=>{:pluralLabel=>:Articulos}},
                                    :properties=>{:url=>{:valueType=>:url} },
                                    :items=>@data.as_json }
      end
    end
  end
end
