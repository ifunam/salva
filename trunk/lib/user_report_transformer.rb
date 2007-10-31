require 'rubygems'
require 'pdf/writer'
require 'pdfwriter_extensions'
require 'textile'
require 'labels'
class UserReportTransformer
  include Textile
  include Labels

  def as_html(data)
    output = ''
    index = 0
    toc = [ ]
    section = [ ]
    data.each do |hash|
      section << { :title => hash[:title], :level => hash[:level]}
      output << "<div class=\"section\">\n" if hash[:level] == 1
      output << internal_link(hash[:title]) + header(get_label(hash[:title]), hash[:level], 'html') + "\n"
      if hash.has_key?(:data)
        output << paragraph(hash[:data].collect { |text|
                              (text.is_a?Array ) ? bold(get_label(text[0]) + ":", 'html') + text[1].to_s + '<br/>': ('# ' + text)
        }.join("\n"))
      end
      index +=1
      if data[index].nil? or data[index][:level] == 1
        toc.push(section)
        section = [ ]
        output << '<span class="back">' + link_to_internal('toc', get_label('back'), "back_top.gif") + "</span>\n"
        output << "\n</div>\n"
      end
    end
    html_toc(toc) + output
  end

  def html_toc(toc) 
   n = 0
   internal_link('toc') + "\n" + table("table(toc).\n" + '|' + toc.collect { |section| html_toc_section(section, n+=1) }.join("|") + '|') + "\n"
  end

  def html_toc_section(section, n)
    section.collect {|item|
      if item[:level] == 1
       link_to_internal(item[:title], get_label(item[:title]), "section#{n}.gif")
      else
        '*' * item[:level] + ' ' + link_to_internal(item[:title], get_label(item[:title]))
      end
    }.join("\n")
  end
end
