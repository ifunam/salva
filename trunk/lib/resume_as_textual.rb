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

  renders [:text, :html],  :for => Resume

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

    table = Table.new(:data => resume[:person] + resume[:address])
    # get_label(label) -> text plain
    bold_tag(get_label(label)) - HTML
    # bold_for_pdf(get_label(label) -> PDF
    text { output << table.to_text}
    html { output << table.to_html}

    pdf { output << table.to_pdf}
  end
#   user = data
#   resume = {
#     :fullname => user.person.fullname,
#     :person  => [  [ 'dateofbirth', user.person.dateofbirth],
#                    [ 'maritalstatus_id', user.person.maritalstatus.name]
#                 ],
#     :address => [  [ 'address', user.addresses.first.as_text],
#                    [ 'phone', user.addresses.first.phone],
#                    [ 'fax', user.addresses.first.fax],
#                    [ 'movil', user.addresses.first.movil],
#                    [ 'email', user.email]
#                 ],
#     :articles => [ user.articles ]
#   }


end


class ResumeAsPdf < Ruport::Formatter::PDF
  renders :pdf, :for => Resume

  def build_resume_from_tree
    add_text "<b>Nombre:</b>" + [data.person.lastname1, data.person.lastname2, data.person.firstname].join(' ')
    render_pdf
  end
end
