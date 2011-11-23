# encoding: utf-8
module ApplicationHelper
  include Salva::SiteConfig
  def add_child_link(name, association)
    link_to(content_tag(:span, '', :class => 'add_child_icon'), "#",
             :"data-association" => association, :class => "add_child_link",
             :title => 'Agregar' )

  end

  def remove_child_link(f)
    html_class = f.object.new_record? ? "remove_new_child" : "remove_existent_child"
    f.hidden_field(:_destroy, :class => :destroy) +
    link_to(content_tag(:span, '', :class => 'del_child_icon'), "#",
                        :class => "#{html_class} child_link",
                        :title => 'Borrrar',
                        :confirm => t(:delete_confirm_question))
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

  def link_to_action(icon_class_name, title, url='#', options={})
    html_options = {:title => title, :class => "action_link #{options[:class]}"}
    options.delete :class if options.has_key? :class
    link_to content_tag(:span, '', :class => icon_class_name), url, html_options.merge(options)
  end

  def link_to_show(resource_path)
    link_to_action 'icon_action_show', t(:show), resource_path
  end

  def link_to_edit(resource_path)
    link_to_action 'icon_action_edit', t(:edit), resource_path
  end

  def link_to_delete(record, resource_path)
    if can_current_user_delete?(record)
      link_to_action 'icon_action_delete', t(:del), resource_path, :method => :delete,
                     :confirm => t(:delete_confirm_question)
    else
      image_tag "locked.png", :title => 'Registro blockeado'
    end
  end

  def link_to_new_record(title, resource_path)
    link_to_action 'icon_action_new_record', title, '#', :class => 'new_record',
                   'data-remote-resource' => resource_path
  end

  def link_to_add_author(title, resource_path)
    link_to_action 'icon_action_add_author', title, "#", 'data-remote-resource' => resource_path
  end

  def link_to_del_author(title, resource_path)
      link_to_action 'icon_action_del_author', title, "#", 'data-remote-resource' => resource_path
  end

  def link_to_add_role(title, resource_path)
    link_to_action 'icon_action_add_role', title, "#", 'data-remote-resource' => resource_path
  end

  def checkbox_to_delete(record)
    if can_current_user_delete?(record) and !record.has_user_id?(current_user.id)
      check_box_tag 'record_id', record.id, false, 'data-parent-id' => dom_id(record)
    else
      image_tag "locked.png", :title => 'Registro blockeado'
    end
  end

  def checkbox_to_del(record)
    if can_current_user_delete? record
      check_box_tag 'record_id', record.id, false, 'data-parent-id' => dom_id(record)
    else
      image_tag "locked.png", :title => 'Registro blockeado'
    end
  end

  def can_current_user_delete?(record)
     record.registered_by_id == current_user.id 
  end

  def link_to_user_list(resource_path)
    link_to '', '#', :title =>t(:author_list), 'data-remote-resource' => resource_path, :class => 'icon_action_user_list'
  end

  def link_to_close_author_list
    link_to_action 'icon_action_close_author_list', 'Cerrar', '#'
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

  def image_for_person(record)
    unless record.image.nil?
      image_tag record.image.file.url(:card)
    else
      image_tag 'avatar_missing_icon.png'
    end
  end

  def registered_by_info(record)
    "#{t(:registered_by)}: " + ( record.registered_by.nil? ? 'admin' : record.registered_by.friendly_email)
  end
  
  def modified_by_info(record)
    "#{t(:updated_by)}: " + record.modified_by.friendly_email unless record.modified_by.nil?
  end

  def updating_date(record)
    "#{t(:updating_date)}: " + ( record.updated_on.to_s (:long)) if record.respond_to? :update_on
  end

  def select_month_for(field_name, prefix = nil)
    select_month(Date.today, {:field_name => field_name, :prefix => prefix}, :class => 'chosen-select')
  end

end
