# Methods added to this helper will be available to all templates in the application.
require 'labels'
require 'finder'
require 'salva'
module ApplicationHelper
    include Labels
    include Salva

  def get_tree_data(tree, parent_id)
    ret = "<div class='outer_tree_element'>"
    tree.each do |node|
      if node.parent_id == parent_id
        node.style = (@ancestors and @ancestors.include?(node.id))? 'display:inline' : 'display:none'
        display_expanded = (@ancestors and @ancestors.include?(node.id))? 'inline' : 'none'
        display_collapsed = (@ancestors and @ancestors.include?(node.id))? 'none' : 'inline'
        ret += "<div class='inner_tree_element' id='#{node.id}_tree_div'>"
        if node.children
          ret += "<img id='#{node.id.to_s}expanded' src='/images/expanded.gif' onclick='javascript: return toggleMyTree(\"#{node.id}\"); ' style='display:#{display_expanded}; cursor:pointer;'  />  "
          ret += "<img style='display:#{display_collapsed}; cursor:pointer;'  id='#{node.id.to_s}collapsed' src='/images/collapsed.gif' onclick='javascript: return toggleMyTree(\"#{node.id.to_s}\"); '  />  "
        end
     
        ret += "<span id='#{node.id}_tree_item'>"
        ret +=  yield node
        ret += "</span>"
        ret += "<span id='#{node.id}children' style='#{node.style}' >"
        ret += get_tree_data(node.children, node.id){|n| yield n}
        ret += "</span>"
        ret += "</div>"
      end
    end
    ret += "</div>"
    return ret
  end

# This section is for the handling of tree
  def get_controller_name
    # get_label(controller_name)
    controller_name
  end

   def controller_name
     @controller.controller_class_name.sub(/Controller$/, '').underscore
   end

   def radio_buttons(attribute ,options)
     s = ''
     options[:values].each do |v|
       if @object.send(attribute).nil?
         s << label_for_boolean(attribute.to_s.downcase, v) + @template.radio_button(@object_name, attribute, v, :checked => false)
       elsif @object.send(attribute) == v
         s << label_for_boolean(attribute.to_s.downcase, v) + @template.radio_button(@object_name, attribute, v, :checked => true )
       else
         s << label_for_boolean(attribute.to_s.downcase, v) + @template.radio_button(@object_name, attribute, v, :checked => false)
       end
     end
     s
   end

   def stop_observer(dom_id)
     javascript_tag " $('#{dom_id.to_s}').stopObserving('click', String.blank);"
     #http://www.prototypejs.org/api/event/stopObserving  (Using String.blank instead nil o nothing)
   end

   def logged_user
     session[:user_id].nil? ? '<login>' : User.find(session[:user_id]).login
   end
  
end
