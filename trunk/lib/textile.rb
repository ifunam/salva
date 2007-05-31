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
      RedCloth.new("h" + level.to_s + ". " + string).to_html
    end
  end

end
