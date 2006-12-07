require "pdf/writer"
require 'pdf/simpletable'
class AnnualActivityReportController < ApplicationController
  def pdf
    
    #'Categoría' => Joposition.find(:first, :include => [:institution], :conditions => ["(institutions.institution_id = 1 OR institutions.id = 1) AND jobpositions.institution_id = institutions.id AND jobpositions.user_id = ?", session[:user]], :order => 'jobpositions.startyear DESC')
    #'Articulos publicados con arbitraje' => :query => Articles.find(), :style => vancouver_articles,
    #'Libros' => :query => Books.find(), :style => vancouver_books,

    pdf = PDF::Writer.new
    pdf.select_font "Helvetica" 
    pdf.text 'Instituto de Física', :font_size => 18, :justification => :center
    pdf.text "Informe anual de actividades", :font_size => 16, :justification => :center
    pdf.move_pointer(30, make_space = false)   
    pdf.text "#{person.lastname1} #{person.lastname2} #{person.firstname}", :font_size => 18, :font_families => :b, :justification => :justify
    
    send_data pdf.render, :filename => "informe.pdf", :type => "application/pdf", :disposition => 'inline'
  end
  # ...
end
