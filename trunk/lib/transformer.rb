require 'rubygems'
require 'pdf/writer'
require 'pdf/quickref'
require 'textile'
class Transformer
  include Textile

  def as_text(data)
    output = ''
    data.each do |item|
      if item.is_a?Hash
        output << header(item[:label], item[:level]) + "\n"
      elsif  item.is_a?Array
        item.each do |text|
          s = (text.is_a?Array ) ? text[0] + ': ' + text[1] :  text
          output <<  s.to_s+"\n"
        end
        output << "\n" if item.size  > 0
      end
    end
    output
  end

  def as_html(data)
    output = ''
    data.each do |item|
      if item.is_a?Hash
        output << header(item[:label], item[:level], 'html') + "\n"
     elsif  item.is_a?Array
        item.each { |text|
          s = (text.is_a?Array ) ? bold(text[0] + ":", 'html') + text[1]:  text
          output << s + "\n<br/>\n"
        }
      end
    end
    output
  end

  def as_pdf(data)
    pdf =  PDF::Writer.new
    data.each {   |item|
      if item.is_a?Hash
        pdf.text(bold(item[:label],'html'), :font_size => (16 - item[:level]))
      elsif  item.is_a?Array
        item.each{ |text|
          s = (text.is_a?Array ) ? bold(text[0] + ":", 'html') + text[1] :  text
          pdf.text(s)
        }
        pdf.text("\n") if item.size  > 0
      end
    }
    pdf.render
  end
end
