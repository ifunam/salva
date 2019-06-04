class Bi::BooksController < Bi::ApplicationController

  def index
    if params[:t]
      @type = params['t']
    elsif params[:commit]
      @type = params['search']['t']
    else
      @type = nil
    end
    @charts = @type=='chapters' ?  Grapher.book_chapters(params) : Grapher.books(params)

    respond_to do |format|
      format.html { render :layout => "bi" }
      format.xml
      format.json do
        mi_json = render :json => { :types=>{:Libro=>{:pluralLabel=>:Libros}},
                                    :properties=>{:url=>{:valueType=>:url} },
                                    :items=>@data.as_json }
      end
    end
  end
end
