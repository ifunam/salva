require 'rubygems'
require 'redcloth'
module Textile

  def bold(string,format='text')
    case  format
      when 'text'
      "'" + string.chars.upcase + "'"
    when 'html'
      RedCloth.new('**' + string + '**', [:lite_mode]).to_html
    end
  end

  def header(string,level=1,format='text')
    case  format
    when 'text'
      string.chars.upcase
    when 'html'
      RedCloth.new("h" + level.to_s + ". " + string, [:no_span_caps]).to_html
    end
  end

  def paragraph(string)
    RedCloth.new(string, [:no_span_caps]).to_html
  end

  def internal_link(string)
    "<a name=\"#{string}\"></a>"
  end

  def link_to_internal(link,string)
    "<a href=\"##{link}\">#{string}</a>"
  end

end
