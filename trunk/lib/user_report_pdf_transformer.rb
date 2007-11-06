require 'rubygems'
require 'textile'
require 'pdf/writer'
require 'pdfwriter_extensions'
require 'labels'

class UserReportPdfTransformer
  include Textile
  include Labels
  
  def as_pdf(data)
  	  pdf =  PDF::Writer.new
  	  
      data.each do |hash|
        pdf.text(header(get_label(hash[:title]), hash[:level], 'textile'))
        pdf.text(paragraph_data(hash[:data])) if hash.has_key?(:data)
      end
      pdf.render
    end

    def paragraph_data(data)
      paragraph(data.collect { |text| 
        if text.is_a?Array  
          bold(get_label(text[0]) + ":", 'html') + text[1].to_s + "\n" if !text[1].nil? and !text[1].blank?
        else  
          ('# ' + text)
        end
      }.compact.join("\n"))
    end
    
end
