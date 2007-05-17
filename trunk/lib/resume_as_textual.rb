require 'resume'
require 'navigator_tree'
require 'labels'
class ResumeAsTextual < Ruport::Formatter::HTML
  include NavigatorTree
  include Labels
  renders [:text, :html], :for => Resume

  def build_resume_from_tree
    tree = tree_loader('resume')
    navigator(tree)
  end

  def navigator(tree)
    tree.children.each { |child|
      if child.has_children?
        section(child.data, child.path.size)
        navigator(child)
      else
        build_output(child)
      end
    }
  end

  def section(section, level)
    text { output << "#{section}, #{level}" }
    tag_level = "h"+level.to_s+". "
    html { output << textile(tag_level+get_label(section))}
  end

  def build_output(child)
    if child.data == 'person'
      section(child.data, child.path.size)
      person
    else
    end
  end

  def person
    html { output << textile("*Nombre:* " + [data.person.lastname1, data.person.lastname2, data.person.firstname].join(' ')) }
    text { output << "Nombre: " + [ data.person.lastname1, data.person.lastname2, data.person.firstname].join(' ') + "\n" }
    text { output << "Edad: " + [ data.person.lastname1, data.person.lastname2, data.person.firstname].join(' ') + "\n" }
  end

  #def build_person

  #end
end

class ResumeAsPdf < Ruport::Formatter::PDF
  renders :pdf, :for => Resume

  def build_resume_from_tree
    add_text "<b>Nombre:</b>" + [data.person.lastname1, data.person.lastname2, data.person.firstname].join(' ')
    render_pdf
  end
end
