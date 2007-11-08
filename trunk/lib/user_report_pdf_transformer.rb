require 'rubygems'
require 'pdf/writer'      
require 'pdfwriter_extensions'
require 'labels'
require 'salva'

class UserReportPdfTransformer
  include Salva
  include Labels
  SIZES = [18, 16, 14, 12, 12, 12]

  def as_pdf(data)
    pdf =  PDF::Writer.new  	  
    pdf.select_font "Times-Roman"

    pdf.text("Informe de Actividades 2007", :font_size => SIZES[0], :justification => :center)
    myinstitution =  get_conf('institution')
    pdf.move_pointer(4)
    pdf.text(myinstitution, :font_size => SIZES[1], :justification => :center)

    pdf.text("\n\n")

    data.each do |hash|
      pdf.text(get_label(hash[:title])+"\n", :font_size => SIZES[hash[:level]]) if hash.has_key?(:title)
      pdf.move_pointer(10)
      paragraph_data(pdf, hash[:data]) if hash.has_key?(:data)
    end
    pdf.render
  end

  def paragraph_data(pdf, data)

    d = []
    width = 40
    data.each do |text| 
      if text.is_a?Array
        label = '<b>'+get_label(text[0])+': </b>' 
        width = pdf.text_line_width(label) if pdf.text_line_width(label) > width
        d << [ label, text[1].to_s ] unless text[1].nil? or text[1].blank?
      else  
        d << { 'key' => ' ', 'value' => 'text' }
      end
    end

    d.each { |row|
      y = pdf.y
      pdf.text(row[0], :font_size => SIZES[5])
      pdf.y = y
      pdf.text(row[1], :font_size => SIZES[5], :left => width) 
      pdf.move_pointer(2)     
    }
  end
  
end
