class Bi::ResearcherCategoriesController < ApplicationController

  def index
    @type = params[:t]!='technician' ? 'researcher' : params[:t]
    @series_name={'technician'=>"Técnicos académicos por categoría",
                  'researcher'=>"Investigadores por categoría"}
    @result = Jobpositioncategory.grouped_researchers(@type)
    @chart = Grapher.simplest_graph('', @result.values, @result.keys, @title, @series_name[@type], '')
    respond_to do |format|
      format.html { render :layout => "bi" }
    end
  end

end
