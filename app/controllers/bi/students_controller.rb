class Bi::StudentsController < ApplicationController
  def index
    if params[:t]
      @type = params['t']
    elsif params[:commit]
      @type = params['search']['t']
    else
      @type = nil
    end
    @res = case
             when @type == 'adsc'
               Grapher.all_adscriptions(params)
             when @type == 'sem'
               Grapher.all_periods(params)
             else
               Grapher.all_years(params)
           end
    @res
    respond_to do |format|
      format.html { render :layout => "bi" }
    end
  end

end
