# encoding: utf-8

module ApplicationHelper
  include Salva::SiteConfig

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
    content_tag(:div, :id => "#{association}_fields_template", :style => "display: none", :class => 'fields_template') do
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
    html_options = {:title => title, :class => "ui-button ui-button-icon ui-widget ui-state-default ui-corner-all #{options[:class]}"}
    options.delete :class if options.has_key? :class
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

  def alphabet_links(attribute_name, url='#')
    %w(A B C D E F G H I J K L M N Ñ O P Q R S T U V W X Y Z).collect { |char|
      link_to char, url, 'data-param-name' => attribute_name.to_s + '_starts_with', 'data-param-value' => char, 'data-controller-name' => controller_name
    }.join(' ').html_safe
  end

  def link_to_delete(record, url)
    if can_current_user_delete?(record)
      link_to_action 'ui-icon-trash', t(:del), url, :method => :delete, :confirm => t(:delete_confirm_question), :remote => true, 'data-parent-id' => dom_id(record)
    end
  end

  def checkbox_to_delete(record)
    check_box_tag 'record_id', record.id, false, 'data-parent-id' => dom_id(record) if can_current_user_delete?(record) and !record.has_user_id?(current_user.id)
  end

  def checkbox_to_del(record)
     check_box_tag 'record_id', record.id, false, 'data-parent-id' => dom_id(record) if can_current_user_delete?(record)
  end

  def can_current_user_delete?(record)
     record.registered_by_id == current_user.id 
  end

  def link_to_user_list(record, url)
    link_to content_tag(:span, '', {:class =>'ui-icon ui-icon-triangle-1-s' }), url, :remote => true, :id => dom_id(record), :title =>  t(:author_list)
  end

  def user_role(record, user_role_class, user_id, foreign_key=nil)
    foreign_key ||= record.class.to_s.foreign_key
    role_class = user_role_class.to_s.classify.constantize
    unless role_class.where(:user_id => user_id, foreign_key => record.id).first.nil? 
      role_class.where(:user_id => user_id, foreign_key => record.id).first
    else
      record.send(user_role_class).build
    end
  end

  def link_to_institution_site
    link_to Salva::SiteConfig.institution('name'), Salva::SiteConfig.institution('url'),
            :target => '_blank'
  end

  def phone_to_technical_support
    link_to_phone Salva::SiteConfig.technical_support('phone')
  end

  def link_to_phone(phone_number)
    number, extension = phone_number.split('ext')
    number.gsub!(/\s|\./,"")
    link_to phone_number, "tel://#{number}"
  end

  def mail_to_technical_support
    mail_to Salva::SiteConfig.technical_support('email')
  end

  def link_to_helpdesk
    helpdesk_url = Salva::SiteConfig.technical_support('helpdesk')
    link_to helpdesk_url, helpdesk_url, :target => '_blank' unless helpdesk_url.nil?
  end
end
