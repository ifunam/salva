# encoding: utf-8
module Admin
  module ApplicationHelper
    def droppable_link(record, association_name)
      link_to(t('admin.'+association_name) + " (#{record.association_records(association_name).size})", '#',
              :id =>  association_name + '_' + dom_id(record), 'data-draggable' => true,
              :class => "ui-state-default ui-corner-all button #{association_name}", 'data-association' => association_name,
              'data-id' => record.id, 'data-controller-name' => controller_name, :title => t(:drop_items))
    end

    def droppable_associations(record)
      record.class.associations_to_move.collect { |association|  droppable_link(record, association.name.to_s)  }.compact.join(' ').html_safe
    end

    def link_to_draggable_action(icon_name, title, record, url='#')
      link_to content_tag(:span, '', :class => "ui-button-icon-primary ui-icon #{icon_name}"), url, :title => title,
              :class => "ui-button ui-button-icon ui-widget ui-state-default ui-corner-all record-draggable",
              'data-record-draggable' => true,  'data-id' => record.id, :id => 'draggable_' + dom_id(record),
              'data-controller-name' => controller_name, 'data-parent-id' => dom_id(record)
    end

    def alphabet_links(attribute_name, url='#')
      %w(A B C D E F G H I J K L M N Ñ O P Q R S T U V W X Y Z).collect { |char|
        link_to char, url, 'data-param-name' => attribute_name.to_s + '_starts_with', 'data-param-value' => char, 'data-controller-name' => controller_name
      }.join(' ').html_safe
    end
  end
end