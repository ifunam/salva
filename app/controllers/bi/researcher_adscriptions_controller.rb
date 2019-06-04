class Bi::ResearcherAdscriptionsController < ApplicationController
  #respond_to "html"
  def index
    @type = params[:t].nil? ? 'researcher' : params[:t]
    @series_name={'technician'=>"Técnicos académicos por departamento",
                      'posdoc'=>"Investigadores posdoctorales por departamento",
                      'researcher'=>"Investigadores por departamento"}
    @result = UserAdscription.grouped_researchers(@type)
    @chart = Grapher.simplest_graph('', @result.values, @result.keys, @title, @series_name[@type], '')
    respond_to do |format|
      format.html { render :layout => "bi" }
    end
  end
end
