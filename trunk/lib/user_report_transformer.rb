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
    toc = []
    section = []
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
        section = []
        output << "</div>\n"
      end
    end
     internal_link('toc') + html_toc(toc) + output
  end

  def html_toc(toc)
    "<table class=\"toc\"><tr>\n" +
      toc.collect { |section|
      "<td>" +
      paragraph(html_toc_section(section)) +
      "</td>\n"}.join("\n") +
      "</tr>\n<tr><td>#{link_to_internal('toc', get_label('top'))}<td></tr></table>\n"
  end

  def html_toc_section(section)
    section.collect {|item|
      if item[:level] == 1
        link_to_internal(item[:title], get_label(item[:title]))
      else
        '*' * item[:level] + ' '+ link_to_internal(item[:title], get_label(item[:title]))
      end
    }.join("\n")
  end
end
