require "pdf/writer"
require 'pdf/simpletable'
class AnnualActivityReportController < ApplicationController
  def pdf
    person = Person.find(:first, :conditions => ['user_id = ?', session[:user]])
    jobposition =  Jobposition.find(:first, :include => [:institution], :conditions => ["(institutions.institution_id = 1 OR institutions.id = 1) AND jobpositions.institution_id = institutions.id AND jobpositions.user_id = ?", session[:user]] )
    useradscription = UserAdscription.find(:first, :conditions => [ 'jobposition_id = ?', jobposition.id])
    
#     production = [
#                   { :label => 'Líneas de investigación', 
#                     :query => UseResearchline.find(:all, :conditions => ['user_id = ?', user_id]), 
#                     :attributes => w%(name)
#                     row.researchline.name
#                     :style => vancouver_articles,
#                   }
#                   # { :label => 'Articulos publicados con arbitraje', 
#                   #  :query => Articles.find(), 
#                   #  :style => vancouver_articles,
#                   #}
#                 ]
    # 'Libros' => :query => Books.find(), :style => vancouver_books,
    
    pdf = PDF::Writer.new
    pdf.select_font "Helvetica" 
    pdf.text 'Instituto de Física', :font_size => 18, :justification => :center
    pdf.text "Informe anual de actividades", :font_size => 16, :justification => :center
    pdf.move_pointer(30, make_space = false)   
    pdf.text "#{person.lastname1} #{person.lastname2} #{person.firstname}", :font_size => 18, :font_families => :b, :justification => :justify
    pdf.text "#{jobposition.jobpositioncategory.roleinjobposition.name} #{jobposition.jobpositioncategory.jobpositionlevel.name} ", :font_size => 18, :font_families => :b, :justification => :justify
    pdf.text "#{useradscription.adscription.name} ", :font_size => 18, :font_families => :b, :justification => :justify
    
#     production.each { |section|
#       #section[:label]
#       section[:query]
#     }

    send_data pdf.render, :filename => "informe.pdf", :type => "application/pdf", :disposition => 'inline'
  end
  # ...
end
