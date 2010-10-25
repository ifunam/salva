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
      link_to(t('admin.'+association_name) + " (#{record.association_records(association_name).size})", '#', 
              :id =>  association_name + '_' + dom_id(record), 'data-draggable' => true, 
              :class => "ui-state-default ui-corner-all button #{association_name}", 'data-association' => association_name, 
              'data-id' => record.id, 'data-controller-name' => controller_name, :title => t(:drop_items))
  end

  def droppable_associations(record)
    record.class.associations_to_move.collect { |association|  droppable_link(record, association.name.to_s)  }.compact.join(' ').html_safe
  end

  def link_to_action(icon_name, title, url='#', options={})
    html_options = {:title => title, :class => "ui-button ui-button-icon ui-widget ui-state-default ui-corner-all"}
    link_to content_tag(:span, '', :class => "ui-button-icon-primary ui-icon #{icon_name}"), url, html_options.merge(options)
  end

  def link_to_draggable_action(icon_name, title, record, url='#')
      link_to content_tag(:span, '', :class => "ui-button-icon-primary ui-icon #{icon_name}"), url, :title => title, 
                          :class => "ui-button ui-button-icon ui-widget ui-state-default ui-corner-all record-draggable", 
                          'data-record-draggable' => true,  'data-id' => record.id, :id => 'draggable_' + dom_id(record), 
                          'data-controller-name' => controller_name, 'data-parent-id' => dom_id(record)
  end

  def link_as_button(title, url, options={})
    class_button = 'button'
    if options.has_key? :class_button
      class_button = options[:class_button]
      options.delete :class_button
    end
    link_to title, url, {:class => "ui-state-default ui-corner-all #{class_button}"}.merge(options)
  end
end
