class Bi::RefereedProceedingsController < ApplicationController
  #respond_to "html"

  def index
    params[:commit] ? year = params[:year].to_i : year = (Time.now.year-1)
    @all_years=UserInproceeding.valid_years
    @series_name="Artículos en memorias arbitradas en "+year.to_s

    @result = UserInproceeding.grouped_refereed_proceedings(year,'t')

    @chart = Grapher.simplest_graph('refereed_proceedings', @result.values, @result.keys, @title, @series_name, '')

    @res=[@all_years,[@chart]]
    @res

    respond_to do |format|
      format.html { render :layout => "bi" }
    end

  end #index
end
