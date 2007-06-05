require 'rubygems'
require 'pdf/writer'
require 'pdf/quickref'
require 'textile'
require 'labels'
class Transformer
  include Textile
  include Labels

  def as_text(data)
    output = ''
    data.each { |item|
      if item.is_a?Hash
        output << header(get_label(item[:label]), item[:section]) + "\n"
      elsif  item.is_a?Array
        item.each { |text|
          s = (text.is_a?Array ) ? get_label(text[0]) + ': ' + text[1] :  text
          output <<  s.to_s+"\n"
        }
        output << "\n" if item.size  > 0
      end
    }
    output
  end

  def as_html(data)
    output = ''
    data.each { |item|
      if item.is_a?Hash
        output << header(get_label(item[:label]), item[:section], 'html') + "\n"
     elsif  item.is_a?Array
        item.each { |text|
          s = (text.is_a?Array ) ? bold(get_label(text[0])+":", 'html') + text[1]:  text
          output << s + "\n<br/>\n"
        }
      end
    }
    output
  end

  def as_pdf(data)
    pdf =  PDF::Writer.new
    data.each {   |item|
      if item.is_a?Hash
        pdf.text(bold(get_label(item[:label]),'html'), :font_size => (16 - item[:section]))
      elsif  item.is_a?Array
        item.each{ |text|
          s = (text.is_a?Array ) ? bold(get_label(text[0])+":", 'html') + text[1] :  text
          pdf.text(s)
        }
        pdf.text("\n") if item.size  > 0
      end
    }
    pdf.render
  end
end
