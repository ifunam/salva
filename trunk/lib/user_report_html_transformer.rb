require 'rubygems'
require 'textile'
require 'labels'
class UserReportHtmlTransformer
  include Textile
  include Labels

  def as_html(data)
    body = ''
    index = 0
    toc = [ ]
    section = [ ]
    data.each do |hash|
      section << { :title => hash[:title], :level => hash[:level]}
      body << "<div class=\"section\">\n" if hash[:level] == 1
      body << internal_link(hash[:title]) + header(get_label(hash[:title]), hash[:level], 'html') + "\n"
      body << paragraph_data(hash[:data])  if hash.has_key?(:data)
      index += 1
      if data[index].nil? or data[index][:level] == 1
        toc.push(section)
        section = [ ]
        body << '<span class="back">' + link_to_internal('toc', get_label('top'), "back_top.gif") + "</span>\n"
        body << "\n</div>\n"
      end
    end
    table_of_content(toc) + body
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

  def table_of_content(toc) 
    n = 0
    internal_link('toc') + "\n" + table("table(toc).\n" + '|' + toc.collect { |section| table_of_content_section(section, (n <= 4 ?  n += 1 : n = 1)) }.join("|") + '|') + "\n"
  end

  def table_of_content_section(section, n)
    section.collect {|item|
      item[:level] == 1 ?  link_to_internal(item[:title], get_label(item[:title]), "section#{n}.gif") : '*' * item[:level] + ' ' + link_to_internal(item[:title], get_label(item[:title]))
    }.join("\n")
  end
end
