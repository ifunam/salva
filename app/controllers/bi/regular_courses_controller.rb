class Bi::RegularCoursesController < ApplicationController
  def index
    params[:commit] ? year = params[:year].to_i : year = (Time.now.year-1)
    @levels = {"Licenciatura"=>["Licenciatura"], "Posgrado"=>["Maestría", "Doctorado"]}
    @series_name="Cursos regulares por departamento"
    #Research
    @grouped_data_deg = Hash.new
    @levels.each_pair { |deg,val| @grouped_data_deg[deg] = 0 }
    @adscriptions_res=UserAdscription.research_adscriptions.map(&:name)
    @grouped_data_res = Hash.new
    @levels.each_pair do |deg,val|
      @grouped_data_res[deg] = Hash.new
      @adscriptions_res.each do |adsc|
        @grouped_data_res[deg][adsc] = UserRegularcourse.grouped_courses(:year=>year, :deg=>val, :adsc=>adsc).length
        @grouped_data_deg[deg] += @grouped_data_res[deg][adsc]
      end
    end
    #Support
    @adscriptions_sup=UserAdscription.support_adscriptions.map(&:name)
    @grouped_data_sup = Hash.new
    @levels.each_pair do |deg,val|
      @grouped_data_sup[deg] = Hash.new
      @adscriptions_sup.each do |adsc|
        @grouped_data_sup[deg][adsc] = UserRegularcourse.grouped_courses(:year=>year, :deg=>val, :adsc=>adsc).length
        @grouped_data_deg[deg] += @grouped_data_sup[deg][adsc]
      end
    end
    #Research
    @adscriptions_res=UserAdscription.research_adscriptions.map(&:name)
    @grouped_data_adsc_res = Hash.new
    @adscriptions_res.each { |adsc| @grouped_data_adsc_res[adsc] = 0 }
    @grouped_data_inv_res = Hash.new
    @adsc=[]
    @adscriptions_res.each do |adsc|
      @adsc << adsc
      @grouped_data_inv_res[adsc] = Hash.new
      @levels.each_pair do |deg,val|
        @grouped_data_inv_res[adsc][deg] = UserRegularcourse.grouped_courses(:year=>year, :deg=>val, :adsc=>adsc).length
        @grouped_data_adsc_res[adsc] += @grouped_data_inv_res[adsc][deg]
      end
    end
    #Support
    @adscriptions_sup=UserAdscription.support_adscriptions.map(&:name)
    @grouped_data_adsc_sup = Hash.new
    @adscriptions_sup.each { |adsc| @grouped_data_adsc_sup[adsc] = 0 }
    @grouped_data_inv_sup = Hash.new
    @adsc=[]
    @adscriptions_sup.each do |adsc|
      @adsc << adsc
      @grouped_data_inv_sup[adsc] = Hash.new
      @levels.each_pair do |deg,val|
        @grouped_data_inv_sup[adsc][deg] = UserRegularcourse.grouped_courses(:year=>year, :deg=>val, :adsc=>adsc).length
        @grouped_data_adsc_sup[adsc] += @grouped_data_inv_sup[adsc][deg]
      end
    end
    @res=[]
    @res.push Grapher.simple_graph('total_courses', @grouped_data_deg, @levels.keys, title='Cursos impartidos anuales', series_title='Total anual por nivel', y_title='') #anual total
    @res.push Grapher.multi_graph('courses_by_department_rev_res', @grouped_data_inv_res, @levels.keys, title='Cursos impartidos por departamento', y_title='') #anual por departamento INV
    @res.push Grapher.multi_graph('courses_by_department_rev_sup', @grouped_data_inv_sup, @levels.keys, title='Cursos impartidos por departamento', y_title='') #anual por departamento INV
    @res.push Grapher.multi_graph('courses_by_department_res', @grouped_data_res, @adscriptions_res, title='Cursos impartidos por departamento', y_title='') #anual por departamento
    @res.push Grapher.multi_graph('courses_by_department_sup', @grouped_data_sup, @adscriptions_sup, title='Cursos impartidos por departamento', y_title='') #anual por departamento
    @res
    #render layout: "bi"
    respond_to do |format|
      format.html { render :layout => "bi" }
    end
  end #index
end

