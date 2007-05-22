require 'rubygems'
require 'ruport'
module Textile
  # HTML methods

  def html
    Ruport::Formatter::HTML.new
  end

  def pdf
    @p = Ruport::Formatter::PDF.new
    @p.options.text_format = { :font_size => 14 }
    @p
  end

  def bold(string,format='text')
    case  format
    when 'text'
      string
    when 'html'
      html.textile '*' + string +'*'
    when 'pdf'
     pdf.add_text "<b>#{string}</b>"
    end
  end

  def header(string,level,format='text')
    case  format
    when 'text'
      string.upcase
    when 'html'
      html.textile "h" + level.to_s + ". " + string
    when 'pdf'
      pdf.add_text(textile("h" + level.to_s + ". " + string))
    end
    end
end
