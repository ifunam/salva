# encoding: utf-8
require File.join(Rails.root.to_s, 'lib/clients/graph_client')

class Grapher
  class << self

  def simple_graph(id, data, categories, title='Gráfica', series_title='serie', y_title='')
    @chart = LazyHighCharts::HighChart.new("graph") do |f|
      f.id(id)
      f.title(text: title)
      f.yAxis [
                  {title: {text: y_title, margin: 30} },
              ]
      f.chart({defaultSeriesType: "column"})
      f.xAxis(categories: categories)
      @data = []
      data.each_key do |datum|
        @data.push data[datum]
      end
      f.series(:name=>series_title,yAxis: 0,:data=>@data)
      f.plot_options(:column=>{
          :dataLabels=>{
              :enabled=>true,
              :color=>"darkgray",
              :style=>{ :font=>"15px Trebuchet MS, Verdana, sans-serif" }
          }
      })
    end
  end

  def simplest_graph(id, data, categories, title='Gráfica', series_title='serie', y_title='')
    @chart = LazyHighCharts::HighChart.new('graph') do |f|
      f.id(id)
      f.title(text: title)
      f.xAxis(categories: categories)
      f.series(name: series_title, yAxis: 0, data:  data)
      f.yAxis [
                  {title: {text: y_title, margin: 30} },
              ]
      f.chart({defaultSeriesType: "column"})
      f.plot_options(:column=>{
          :dataLabels=>{
              :enabled=>true,
              :color=>"darkgray",
              :style=>{ :font=>"15px Trebuchet MS, Verdana, sans-serif" }
          }
      })
    end

  end

  def multi_graph(id, data, categories, title='Gráfica', y_title='')
    @chart = LazyHighCharts::HighChart.new("graph") do |f|
      f.id(id)
      f.title(text: title)
      f.yAxis [
                  {title: {text: y_title, margin: 30} },
              ]
      f.chart({defaultSeriesType: "column"})
      f.xAxis(categories: categories)
      data.each_key do |datum|
        @series = Array.new
        data[datum].each_key do |serie|
          @series << data[datum][serie]
        end
        f.series(:name=>datum,yAxis: 0,:data=>@series)
      end
      f.plot_options(:column=>{
          :dataLabels=>{
              :enabled=>true,
              :color=>"darkgray",
              :style=>{ :font=>"15px Trebuchet MS, Verdana, sans-serif" }
          }
      })
    end
  end

  def multi_graph_stack(id, data, categories, title='Gráfica', y_title='')
    @chart = LazyHighCharts::HighChart.new("graph") do |f|
      f.id(id)
      f.title(text: title)
      f.yAxis [
                  {title: {text: y_title, margin: 30} },
              ]
      f.chart({defaultSeriesType: "column"})
      f.xAxis(categories: categories)
      data.each_key do |datum|
        @series = Array.new
        data[datum].each_key do |serie|
          @series << data[datum][serie]
        end
        f.series(:name=>datum,yAxis: 0,:data=>@series)
      end
      f.plot_options(:column=>{
          :stacking=>'normal',
          :dataLabels=>{
              :enabled=>true,
              :color=>"darkgray",
              :style=>{ :font=>"15px Trebuchet MS, Verdana, sans-serif" }
          }
      })
    end
  end

  def multi_graph_simple(id, data, categories, title='Gráfica', y_title='')
    @chart = LazyHighCharts::HighChart.new('graph') do |f|
      f.id(id)
      f.title(text: title)
      f.xAxis(categories: categories)
      data['series_data'].each do |serie|
        f.series(:name=>serie['name'], yAxis: 0,:data=>serie['data'])
      end
      f.yAxis [ {title: {text: y_title, margin: 30} }, ]
      f.chart({defaultSeriesType: "column"})
      f.plot_options(:column=>{
          :dataLabels=>{
              :enabled=>true,
              :color=>"darkgray",
              :style=>{ :font=>"15px Trebuchet MS, Verdana, sans-serif" }
          }
      })
    end
  end

  def knowledge_fields(params={})
    @kas = KnowledgeArea.order(:knowledge_field_id,:id)
    @kfs = KnowledgeField.order(:id)
    @type = params[:t] ? params[:t] : 'research'
    @aux = Hash.new
    @kfs.each { |kf| @aux[kf.id] = [] }
    @kas.each do |ka|
      @aux[ka.knowledge_field_id].concat UserKnowledgeArea.grouped_users(ka.id,@type)
    end
    @grouped_data = Hash.new
    @grouped_data_rep = Hash.new
    @kfs.each do |kf|
      @grouped_data_rep[kf.name] = @aux[kf.id].size
      @grouped_data[kf.name] = @aux[kf.id].uniq.size
    end
    tipo = case @type
      when 'technician' then 'Técnicos académicos'
      when 'posdoc' then 'Estudiantes posdoctorales'
      else 'Investigadores y cátedras CONACyT'
    end
    @res=[]
    @res.push simple_graph('knowledge_areas', @grouped_data, @grouped_data.keys, title='Académicos por campo del conocimiento', series_title=tipo, y_title='') #total
    @res.push simple_graph('knowledge_areas_rep', @grouped_data_rep, @grouped_data_rep.keys, title='Académicos por campo del conocimiento (con repetidos)', series_title=tipo, y_title='') #total
    @res
  end #knowledge_areas

  def book_chapters(params)
    if params[:commit]
      @years = (params[:initial_year] .. params[:final_year]).to_a
    else
      @years = (2012 .. Time.now.year).to_a
    end
    @grouped_data = Hash.new
    @years.each do |year|
      @grouped_data[year] = ChapterinbookRoleinchapter.published.authors.find_by_year(year).count
    end
    @res=[]
    @res.push simple_graph('total_books', @grouped_data, @years, title='Capítulos escritos por académicos del IF', series_title='total anual', y_title='') #anual total
    @res
  end #book_chapters

  def books(params)
    if params[:commit]
      @years = (params[:initial_year] .. params[:final_year]).to_a
    else
      @years = (2012 .. Time.now.year).to_a
    end
    @grouped_data = Hash.new
    @years.each do |year|
      @grouped_data[year] = BookeditionRoleinbook.published.authors.find_by_year(year).count
    end
    @res=[]
    @res.push simple_graph('total_books', @grouped_data, @years, title='Libros escritos por académicos del IF', series_title='total anual', y_title='') #anual total
    @res
  end #books

  def verified_articles_journal(params)
    if params[:commit]
      @years = (params[:initial_year] .. params[:final_year]).to_a
    else
      @years = (2012 .. Time.now.year).to_a
    end
    @countries = ['Nacionales','Internacionales']
    @grouped_data = Hash.new
    @countries.each do |country|
      @grouped_data[country] = Hash.new
      @years.each do |year|
        @grouped_data[country][year] = Article.articles_mexican_journal(:year=>year, :country=>country).count
      end
    end
    @res=[]
    @res.push multi_graph_stack('articles_by_journal_type', @grouped_data, @years, title='Publicaciones por tipo de revista', y_title='Publicaciones verificadas') #anual por tipo de revista
    @res
  end #verified_articles_journal

  def verified_articles(params)
    if params[:commit]
      @years = (params[:initial_year] .. params[:final_year]).to_a
    else
      @years = (2012 .. Time.now.year).to_a
    end
    @data_year = Hash.new
    @years.each do |year|
      @data_year[year] = Article.grouped_articles(:year=>year)#, :adsc=>adsc)
    end
    #Research adscriptions
    @adscriptions = UserAdscription.research_adscriptions
    @grouped_data_res = Hash.new
    @grouped_data_year = Hash.new
    @years.each { |year| @grouped_data_year[year] = 0 }
    @adscriptions.map(&:name).each do |adsc|
      @grouped_data_res[adsc] = Hash.new
      @years.each do |year|
        @grouped_data_res[adsc][year] = @data_year[year][adsc].to_i
        @grouped_data_year[year] += @grouped_data_res[adsc][year]
      end
    end
    #Support adscriptions
    @adscriptions = UserAdscription.support_adscriptions
    @grouped_data_sup = Hash.new
    @adscriptions.map(&:name).each do |adsc|
      @grouped_data_sup[adsc] = Hash.new
      @years.each do |year|
        @grouped_data_sup[adsc][year] = @data_year[year][adsc].to_i
        @grouped_data_year[year] += @grouped_data_sup[adsc][year]
      end
    end
    @res=[]
    @res.push simple_graph('total_articles', @grouped_data_year, @years, title='Publicaciones anuales', series_title='total anual', y_title='Publicaciones verificadas') #anual total
    @res.push multi_graph('articles_by_research', @grouped_data_res, @years, title='Publicaciones por departamento de investigación', y_title='Publicaciones verificadas') #anual por departamento de inv
    @res.push multi_graph('articles_by_support', @grouped_data_sup, @years, title='Publicaciones por departamento de apoyo', y_title='Publicaciones verificadas') #anual por departamento de apoyo
    @res
  end #verified_articles

  def repeated_verified_articles(params)
    if params[:commit]
      @years = (params[:initial_year] .. params[:final_year]).to_a
    else
      @years = (2012 .. Time.now.year).to_a
    end
    @grouped_data_year = Hash.new
    @years.each do |year|
      @grouped_data_year[year] = 0
    end
    #Research
    @adscriptions = UserAdscription.research_adscriptions.map(&:name)
    @grouped_data_res = Hash.new
    @adscriptions.each do |adsc|
      @grouped_data_res[adsc] = Hash.new
      @years.each do |year|
        @grouped_data_res[adsc][year] = Article.repeated_grouped_articles(:year=>year, :adsc=>adsc).length
        @grouped_data_year[year] += @grouped_data_res[adsc][year]
      end
    end
    #Support
    @adscriptions = UserAdscription.support_adscriptions.map(&:name)
    @grouped_data_sup = Hash.new
    @adscriptions.each do |adsc|
      @grouped_data_sup[adsc] = Hash.new
      @years.each do |year|
        @grouped_data_sup[adsc][year] = Article.repeated_grouped_articles(:year=>year, :adsc=>adsc).length
        @grouped_data_year[year] += @grouped_data_sup[adsc][year]
      end
    end
    @res=[]
    @res.push simple_graph('total_articles', @grouped_data_year, @years, title='Publicaciones anuales', series_title='total anual', y_title='Publicaciones verificadas') #anual total
    @res.push multi_graph('articles_by_department_res', @grouped_data_res, @years, title='Publicaciones por departamento de investigación', y_title='Publicaciones verificadas')
    @res.push multi_graph('articles_by_department_sup', @grouped_data_sup, @years, title='Publicaciones por departamento de apoyo', y_title='Publicaciones verificadas')
    @res
  end #repeated_verified_articles

  def all_years(params)
    @periods = GraphClient.new(params).all_years
    if params[:t]
      @t = params['t']
    elsif params[:commit]
      @t = params['search']['t']
    else
      @t = nil
    end
    @sem = Hash.new
    @periods[0]['reports'].each do |period|
      @sem[period] = period
    end
    @name = @periods[1]['options']['title']['text']
    @data = @periods[1]['series_data'][0]['data']
    @categories = @periods[1]['options']['xAxis']['categories']
    @charts = []
    @charts.push simplest_graph('students_per_year', @data, @categories, title=' ', series_title=@name, y_title='') # Estudiantes por periodo

    @name = @periods[2]['options']['title']['text']
    @data = @periods[2]
    @categories = @periods[2]['options']['xAxis']['categories']
    @charts.push multi_graph_simple('students_per_year_category', @data, @categories, title='', y_title='') # Estudiantes por actividad-año
    @res = {:periods=>@sem, :charts=>@charts, :t=>@t}
    @res
  end

  def all_periods(params)
    @periods = GraphClient.new(params).all_periods
    if params[:t]
      @t = params['t']
    elsif params[:commit]
      @t = params['search']['t']
    else
      @t = nil
    end
    @sem = Hash.new
    @periods[0]['reports'].each do |period|
      @sem[period['name']] = period['id']
    end
    @name = @periods[1]['options']['title']['text']
    @data = @periods[1]['series_data'][0]['data']
    @categories = @periods[1]['options']['xAxis']['categories']
    @charts = []
    @charts.push simplest_graph('students_per_period', @data, @categories, title=' ', series_title=@name, y_title='') # Estudiantes por periodo

    @name = @periods[2]['options']['title']['text']
    @data = @periods[2]
    @categories = @periods[2]['options']['xAxis']['categories']
    @charts.push multi_graph_simple('students_per_period_category2', @data, @categories, title='', y_title='') # Estudiantes por actividad-periodo
    @res = {:periods=>@sem, :charts=>@charts, :t=>@t}

    @res = {:periods=>@sem, :charts=>@charts, :t=>@t}
    @res
  end

  def all_adscriptions(params)
    @adscriptions = GraphClient.new(params).all_adscriptions
    if params[:t]
      @t = params['t']
    elsif params[:commit]
      @t = params['search']['t']
    else
      @t = nil
    end
    @sem = Hash.new
    @adscriptions[0]['reports'].each do |period|
      @sem[period['name']] = period['id']
    end
    @name = @adscriptions[1]['options']['title']['text']
    @data = @adscriptions[1]['series_data'][0]['data']
    @charts = []
    @categories = @adscriptions[1]['options']['xAxis']['categories']
    @charts.push simplest_graph('students_per_period', @data, @categories, title=' ', series_title=@name, y_title=' ') #anual total
    @res = {:periods=>@sem, :charts=>@charts, :t=>@t}
    @res
  end

  end #class
end
