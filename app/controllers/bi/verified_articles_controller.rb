class Bi::VerifiedArticlesController < Bi::ApplicationController

  def show_graph
    if params[:t]
      @type = params['t']
    elsif params[:commit]
      @type = params['search']['t']
    else
      @type = nil
    end

    @charts = case @type
      when 'repeated'
        Grapher.repeated_verified_articles(params)
      when 'journal'
        Grapher.verified_articles_journal(params)
      else
        Grapher.verified_articles(params)
      end

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

