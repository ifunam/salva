class Bi::ResearcherAgesController < ApplicationController

  def index
    @type = params[:t].nil? ? 'researcher' : params[:t]
    @series_name={'technician'=>"Técnicos académicos por edades",
                      'posdoc'=>"Investigadores posdoctorales por edades",
                      'researcher'=>"Investigadores por edades"}
    @result = Person.grouped_researchers(@type)
    @chart = Grapher.simplest_graph('', @result.values, @result.keys, @title, @series_name[@type], '')
    respond_to do |format|
      format.html {render layout: "bi"}
    end
  end

end
