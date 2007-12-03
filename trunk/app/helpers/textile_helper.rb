require 'labels'
require 'redcloth'
module TextileHelper
  include Labels

  def table_of_content(data)
    n = 0
    '|' + toc_extractor(data).collect { |section| toc_section(section, (n <= 4 ?  n += 1 : n = 1)) }.join("|") + '|'
  end

  def toc_extractor(data)
    index = 0
    toc = [ ]
    section = [ ]
    data.each do |hash|
      section << { :title => hash[:title], :level => hash[:level]}
      index += 1
      toc.push(section) and section = [] if data[index].nil? or data[index][:level] == 1
    end
    toc
  end

  def toc_section(section, n)
   section.collect {|item|
      if item[:level] == 1
          link_to_internal(item[:title], get_label(item[:title]), "section#{n}.gif")
      else
         '*' * item[:level] + ' ' + link_to_internal(item[:title], get_label(item[:title]))
      end
    }.join("\n")
  end

  def paragraph_data(data)
    paragraph(data.collect { |text|
      if text.is_a?Array
        bold(get_label(text[0]) + ":", 'html') + text[1].to_s + '<br/>' if !text[1].nil? and !text[1].blank?
      else
        ('# ' + text)
      end
    }.compact.join("\n"))
  end

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

  def link_to_internal(link,string,img=nil)
    img == nil ? RedCloth.new("\"#{string}\":##{link}", [:lite_mode, :no_span_caps]).to_html : RedCloth.new("!/images/#{img}!:##{link}", [:lite_mode, :no_span_caps]).to_html + RedCloth.new("\"#{string}\":##{link}", [:lite_mode, :no_span_caps]).to_html
  end

  def table(t)
    RedCloth.new(t).to_html
  end
end
