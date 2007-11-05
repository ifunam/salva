require 'yaml'
module Labels
  def label_for_boolean(column,condition)
    condition = (condition == 't' ? true : false) if condition.is_a? String
    case column
    when /gender/
      condition ? get_label('male') : get_label('female')
    when /is_studying_this/
      condition ? get_label('inprogress_degree') : get_label('finished_degree')
    when /has_group_right/
      condition ? get_label('group_permission') : get_label('without_group_permission')
    when /ismainauthor/
      condition ? get_label('mainauthor') : get_label('coauthor')
    when /isseminary/
      condition ? get_label('myseminary') : get_label('talk')
    else
      condition ? get_label('yes') : get_label('no')
    end
  end

  def get_label(name)
    ymlfile =  File.join(RAILS_ROOT, 'po', 'salva.yml')
    salva = YAML::parse(File.open(ymlfile))
    labels = salva.transform
    labels['yes'] = 'Sí'
    labels['no'] = 'No'
    labels[name] ? labels[name] : "#{name} no esta definido en #{ymlfile}"
  end
end
