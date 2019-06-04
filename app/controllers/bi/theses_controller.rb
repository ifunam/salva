class Bi::ThesesController < ApplicationController
  #respond_to "html"
  def index
    params[:commit] ? year = params[:year] : year = Time.now.year-1
    @level_names = ["Licenciatura", "Maestría", "Doctorado","Sin"]
    @level_hash = {3=>"Licenciatura", 5=>"Maestría", 6=>"Doctorado", nil=>"Sin"}
    @levels = [3, 5, 6, nil]
    @series_name="Tesis dirigidas por departamento de investigación"
    @grouped_data_deg = Hash.new
    @levels.each { |deg| @grouped_data_deg[deg] = 0 }
    #Research
    @adscriptions_res = UserAdscription.research_adscriptions.map(&:name)
    @grouped_data_res = Hash.new
    @levels.each do |deg|
      @grouped_data_res[@level_hash[deg]] = Hash.new
      @adscriptions_res.each do |adsc|
        @grouped_data_res[@level_hash[deg]][adsc] = UserThesis.grouped_theses(:year=>year, :deg=>deg, :adsc=>adsc).length
        @grouped_data_deg[deg] += @grouped_data_res[@level_hash[deg]][adsc]
      end
    end
    #Support
    @adscriptions_sup = UserAdscription.support_adscriptions.map(&:name)
    @grouped_data_sup = Hash.new
    @levels.each do |deg|
      @grouped_data_sup[@level_hash[deg]] = Hash.new
      @adscriptions_sup.each do |adsc|
        @grouped_data_sup[@level_hash[deg]][adsc] = UserThesis.grouped_theses(:year=>year, :deg=>deg, :adsc=>adsc).length
        @grouped_data_deg[deg] += @grouped_data_sup[@level_hash[deg]][adsc]
      end
    end
    #Research INV
    @grouped_data_adsc_res = Hash.new
    @adscriptions_res.each { |adsc| @grouped_data_adsc_res[adsc] = 0 }
    @grouped_data_inv_res = Hash.new
    @adscriptions_res.each do |adsc|
      @grouped_data_inv_res[adsc] = Hash.new
      @levels.each do |deg|
        @grouped_data_inv_res[adsc][deg] = UserThesis.grouped_theses(:year=>year, :deg=>deg, :adsc=>adsc).length
        @grouped_data_adsc_res[adsc] += @grouped_data_inv_res[adsc][deg]
      end
    end
    #Support INV
    @grouped_data_adsc_sup = Hash.new
    @adscriptions_sup.each { |adsc| @grouped_data_adsc_sup[adsc] = 0 }
    @grouped_data_inv_sup = Hash.new
    @adscriptions_sup.each do |adsc|
      @grouped_data_inv_sup[adsc] = Hash.new
      @levels.each do |deg|
        @grouped_data_inv_sup[adsc][deg] = UserThesis.grouped_theses(:year=>year, :deg=>deg, :adsc=>adsc).length
        @grouped_data_adsc_sup[adsc] += @grouped_data_inv_sup[adsc][deg]
      end
    end

    @res=[]
    @res.push Grapher.simple_graph('total_theses', @grouped_data_deg, @level_names, title='Tesis dirigidas anuales', series_title='Total anual por nivel', y_title='Tesis verificadas') #anual total
    @res.push Grapher.multi_graph('theses_by_department_inv_res', @grouped_data_inv_res, @level_names, title='Tesis dirigidas por departamento de investigación', y_title='Tesis verificadas') #anual por departamento INV
    @res.push Grapher.multi_graph('theses_by_department_inv_sup', @grouped_data_inv_sup, @level_names, title='Tesis dirigidas por departamento de apoyo', y_title='Tesis verificadas') #anual por departamento INV
    @res.push Grapher.multi_graph('theses_by_department_res', @grouped_data_res, @adscriptions_res, title='Tesis dirigidas por departamento de investigación', y_title='Tesis verificadas') #anual por departamento
    @res.push Grapher.multi_graph('theses_by_department_sup', @grouped_data_sup, @adscriptions_sup, title='Tesis dirigidas por departamento de apoyo', y_title='Tesis verificadas') #anual por departamento
    @res
    #render layout: "bi"
    respond_to do |format|
      format.html { render :layout => "bi" }
    end

  end #index
end

