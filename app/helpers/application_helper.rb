module ApplicationHelper
  def remove_child_link(name, f)
    f.hidden_field(:id) + link_to((content_tag(:span, '', :class => 'ui-button-icon-primary ui-icon ui-icon-trash')), "javascript:void(0)", :class => "remove_child ui-button ui-button-icon ui-widget ui-state-default ui-corner-all")
  end

  def remove_remote_child(name, f)
    dom_id = 'remove_' + ActiveSupport::Inflector.underscore(f.object.class.name)
    link_to content_tag(:span, '', :class => 'ui-button-icon-primary ui-icon ui-icon-trash'), "javascript:void(0)", :class => "#{name} ui-button ui-button-icon ui-widget ui-state-default ui-corner-all", :id => f.object.id
  end

  def add_child_link(name, association)
    link_to((content_tag(:span, '', :class => 'ui-button-icon-primary ui-icon ui-icon-plus')), "javascript:void(0)",  :"data-association" => association, :class => "add_child ui-button ui-button-icon ui-widget ui-state-default ui-corner-all")
  end

  def new_child_fields_template(form_builder, association, options = {})
    options[:object] ||= form_builder.object.class.reflect_on_association(association).klass.new
    options[:partial] ||= association.to_s.singularize
    options[:form_builder_local] ||= :f
    content_tag(:div, :id => "#{association}_fields_template", :style => "display: none") do
      form_builder.fields_for(association, options[:object], :child_index => "new_#{association}") do |f|
        render(:partial => options[:partial], :locals => {options[:form_builder_local] => f})
      end
    end
  end
  
  def droppable_link(record, association_name)
      link_to(t('admin.'+association_name) + " (#{record.send(association_name.to_sym).size})", '#', 
              :id =>  association_name + '_' + dom_id(record), 'data-draggable' => true, 
              :class => "ui-state-default ui-corner-all button #{association_name}", 'data-association' => association_name, 
              'data-id' => record.id, 'data-controller-name' => controller_name, :title => t(:drop_items))
  end
  
end
