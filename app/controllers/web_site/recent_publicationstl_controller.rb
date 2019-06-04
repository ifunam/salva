class WebSite::RecentPublicationstlController < WebSite::ApplicationController

  def index
    @data = []
    @data.concat(Article.published.verified.current_year)
    @data.concat(Article.published.verified.last_year)
    respond_to do |format|
      format.html {render layout: false}
      format.xml
      format.json do
        mi_json = render :json => { :types=>{:Articulo=>{:pluralLabel=>:Articulos}},
                  :properties=>{:url=>{:valueType=>:url} },
                  :items=>@data.as_json }
      end
    end
  end

end
