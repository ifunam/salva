class Bi::ImpactFactorsController < ApplicationController

  def index
    params[:commit] ? @year = params[:year] : @year = Time.now.year-1
    @result = Article.articles_by_impact_factor(@year)
    @n_a = @result['n/a']
    @result.delete('n/a')
    @series_name = "Artículos publicados por factor de impacto"
    @chart = Grapher.simplest_graph('', @result.values, @result.keys, @title, @series_name, '')
    respond_to do |format|
      format.html {render layout: "bi"}
    end
  end

end
