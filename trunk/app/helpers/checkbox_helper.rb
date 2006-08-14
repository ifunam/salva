require 'list_helper'
require 'application_helper'
module CheckboxHelper   
  def checkbox_array(object, model, values=nil)
    collection = model.find(:all)
    list = []
    collection.collect { |c|
      list << [ columns_content(c, get_attributes(c)).join(', '), c.id ]
    }
    logger.info "check_box_ids" +values.to_s
    checkbox_group(object, model, list, values)
  end
  
  def tree_checkbox_list(object, model, columns, values=nil)
    collection = model.find(:all)
    list = list_collection(collection, columns)
    checkbox_group(object, model, list, values)
  end
  
  def checkbox_group(object, model, collection, values=nil)
    ckbox_group = "<ul>\n"
    collection.collect { |name, id| 
      checked_id = values.include?(id) if values != nil
      ckbox_group << li_tag(object, model, id, name, checked_id)
    }
    ckbox_group << "</ul>\n"
  end

  def li_tag(object, model, id, name, checked_id)
    '<li>' + check_box_tag("#{object}[#{model_id(model)}][]", id, checked = checked_id) + name + "</li>\n"
  end
end
