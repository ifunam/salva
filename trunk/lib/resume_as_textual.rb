require 'resume'
require 'navigator_tree'
require 'labels'
require 'ruport/data'
require 'textile'
class ResumeAsTextual < Ruport::Formatter::HTML
  include NavigatorTree
  include Labels
  include Ruport::Data
  include Textile

  renders [:text, :html], :for => Resume

  def build_resume_from_tree
    tree = tree_loader('resume')
    navigator(tree)
  end

  def navigator(tree)
    tree.children.each { |child|
      if child.has_children?
        section(child.data, child.path.size)
        if child.data == 'general'
          general
          next
        else
          navigator(child)
        end
      else
        build_output(child)
      end
    }
  end

  def build_output(child)
    if child.data == 'article'
      'article list'
    else
    end
  end

  def section(section, level)
    text { output << header_text(get_label(section), level)}
    html { output << header_tag(get_label(section), level)}
  end

  def general
    text { output << data.person.fullname + "\n"}
    html { output << bold_tag(data.person.fullname) }

    table = Table.new(:data => person + address)
    text { output << table.to_text}
    html { output << table.to_html}
  end

  def person
    [ [ get_label('dateofbirth'), data.person.dateofbirth],
      [ get_label('maritalstatus_id'), data.person.maritalstatus.name]
    ]
  end

  def address
    [
     [ get_label('address'), data.addresses.first.as_text],
     [ get_label('phone'), data.addresses.first.phone],
     [ get_label('fax'), data.addresses.first.fax],
     [ get_label('movil'), data.addresses.first.movil],
     [ get_label('email'), data.email]
    ]
  end
end


class ResumeAsPdf < Ruport::Formatter::PDF
  renders :pdf, :for => Resume

  def build_resume_from_tree
    add_text "<b>Nombre:</b>" + [data.person.lastname1, data.person.lastname2, data.person.firstname].join(' ')
    render_pdf
  end
end
