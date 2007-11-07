require 'rubygems'
require 'pdf/writer'      
require 'pdf/simpletable'
require 'pdfwriter_extensions'
require 'labels'

class UserReportPdfTransformer
  include Labels
  SIZES = [18, 16, 14, 12, 12, 12]

  def as_pdf(data)
    pdf =  PDF::Writer.new  	  

    data.each do |hash|
      pdf.text(get_label(hash[:title]), :font_size => SIZES[hash[:level]]) if hash.has_key?(:title)
#      
      paragraph_data(pdf, hash[:data]) if hash.has_key?(:data)
    end
    pdf.render
  end

  def paragraph_data(pdf, data)
    d = []
    data.each do |text| 
      if text.is_a?Array  
        d << { 'key' => '<b>'+get_label(text[0])+'</b>',
          'value' => text[1].to_s }
        pdf.text('<b>'+get_label(text[0])+': </b>', :font_size => SIZES[5])
        pdf.text(text[1].to_s)
      else  
        d << { 'key' => ' ', 'value' => text }
      end
    end
    return;
    
    PDF::SimpleTable.new do |tab|
       tab.column_order.push(*%w(key value))
      
      tab.columns["key"] = PDF::SimpleTable::Column.new("key") { |col|
        col.heading = "Key"
      }
      tab.columns["Value"] = PDF::SimpleTable::Column.new("value") { |col|
        col.heading = "Value"
      }
      tab.show_lines    = :all
      tab.show_headings = false
      tab.orientation   = :center
      tab.position      = :center
      
      tab.data.replace d
      tab.render_on(pdf)
    end
  end
  
end
