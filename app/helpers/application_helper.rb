# encoding: utf-8
module ApplicationHelper
  include Salva::SiteConfig
  include ActionView::RecordIdentifier
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
                        :data => { confirm: t(:delete_confirm_question) })
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

  def link_to_edit_not_verified(record, resource_path)
    unless verified_record?(record)
      link_to_action 'icon_action_edit', t(:edit), resource_path
    else
      image_tag "locked.png", :title => 'Registro verificado'
    end
  end

  def link_to_delete(record, resource_path)
    if can_current_user_delete?(record)
      link_to_action 'icon_action_delete', t(:del), resource_path, :method => :delete,
                     :data => { confirm: t(:delete_confirm_question) }
    else
      image_tag "locked.png", :title => 'Registro verificado'
    end
  end

  def link_to_new_record(title, resource_path)
    link_to_action 'icon_action_new_record', title, resource_path, :class => 'new_record', :remote => true
  end

  def link_to_add_author(title, resource_path)
    link_to_action 'icon_action_add_author', title, resource_path
  end

  def link_to_del_author(title, resource_path)
      link_to_action 'icon_action_del_author', title, resource_path
  end

  def link_to_add_role(title, resource_path)
    link_to_action 'icon_action_add_role', title, resource_path
  end

  def checkbox_to_delete(record)
    if can_current_user_delete?(record) #and !record.has_user_id?(current_user.id)
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
     record.registered_by_id == current_user.id  and !verified_record?(record)
  end

  def verified_record?(record)
    if record.respond_to? :is_verified
      record.is_verified?
    else
      false
    end
  end

  def link_to_user_list(resource_path)
    link_to '', resource_path, :title =>t(:author_list), :class => 'icon_action_user_list'
  end

  def link_to_close_author_list
    link_to_action 'icon_action_close_author_list', 'Cerrar', '#'
  end

  def link_to_delete_period(resource_path)
    link_to_action 'icon_action_delete_period', t(:del), resource_path, :method => :delete, :data => { confirm: t(:delete_confirm_question) },
                   :class => 'delete_period', :remote => true
  end

  def link_to_download(record)
    if File.exist? record.new_file_path
      #Rails.logger.info 'link_to_download : new_file_path.exist'
      login = record.user.login
      link = record.file_path.match('annual_reports').nil? ? department_annual_plans_document_path : department_annual_reports_document_path
      link_to_action 'icon_action_download', t(:download), link+'.pdf?id='+record.id.to_s, :target => '_blank'
    elsif File.exist? record.file_path
      #Rails.logger.info 'link_to_download : file_path.exist'
      link_to_action 'icon_action_download', t(:download), record.url, :target => '_blank'
    else
      'En proceso...'
    end
  end

  def link_to_annual_report(user_id)
    @document_type = Documenttype.annual_reports.active.first
    unless @document_type.nil?
      @annual_report = AnnualReport.find_by_user_id_and_documenttype_id(user_id, @document_type.id)
      if !@document_type.nil? and @annual_report.nil?
        link_to t(:new_annual_report), new_user_annual_report_path
      elsif !@document_type.nil? and !@annual_report.nil? and @annual_report.undelivered_or_rejected?
        link_to t(:edit_annual_report), edit_user_annual_report_path(:id => @annual_report.id)
      end
    end
  end

  def link_to_annual_plan(user_id)
    @document_type = Documenttype.annual_plans.active.first
    unless @document_type.nil?
      @annual_plan= AnnualPlan.find_by_user_id_and_documenttype_id(user_id, @document_type.id)
      if !@document_type.nil? and @annual_plan.nil?
        link_to t(:new_annual_plan), new_user_annual_plan_path
      elsif !@document_type.nil? and !@annual_plan.nil? and @annual_plan.undelivered_or_rejected?
        link_to t(:edit_annual_plan), edit_user_annual_plan_path(:id => @annual_plan.id)
      end
    end
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

  def document_status_indicator(status)
    if status == true
      image_tag('associated_record.png', :class => 'associated_record_indicator', :title => t(:approved))
    else
      image_tag('error_status.png', :class => 'associated_record_indicator', :title => t(:rejected))
    end
  end

  def link_to_approve_annual_plan(record, resource_path)
    if record.documenttype.status == true
      link_to t(:approve), resource_path[0..-4], :remote => true, :class => 'approve_document'#, :confirm => t(:approve_document)
      #FIX IT resource_path contains an additional '.js?'; [0..-4] cuts it of
      #       should be like:
      #link_to t(:approve), resource_path, :remote => true, :class => 'approve_document', :confirm => t(:approve_document)
    end
  end

  def link_to_approve_document(record, resource_path)
    if record.documenttype.status == true
      link_to t(:approve), resource_path[0..-4], :remote => true, :class => 'approve_document'
      #FIX IT resource_path contains an additional '.js?'; [0..-4] cuts it of
      #       should be like:
      #link_to t(:approve), resource_path, :remote => true, :class => 'approve_document'
    end
  end

  def link_to_reject_document(record, resource_path)
    if record.documenttype.status == true
      link_to t(:reject), resource_path, :remote => true, :class => 'reject_document'
    end
  end

  def search_enabled?
    session[:search_enabled].is_a? TrueClass
  end

  def search_links
    if search_enabled?
      link_to(t(:disable_search), "#", :id => 'disable_search') +
      link_to(t(:enable_search), "#", :id => 'enable_search', :style => 'display: none')
    else
      link_to(t(:disable_search), "#", :id => 'disable_search', :style => 'display: none') +
      link_to(t(:enable_search), "#", :id => 'enable_search')
    end
  end

  def search_form_display_enabled
    "display: #{!search_enabled? ?  'none' : 'run-in' }"
  end

  def link_and_label_for(url)
    label_and_link = tr_label_for(:url)
    unless url.to_s.strip.empty?
      label_and_link += link_to t(:open_url), @article.url, :target => '_blank'
    else
      label_and_link += t(:blank).html_safe
    end
    label_and_link
  end

  def tr_label_for(label)
    content_tag(:strong, t(label), :class => 'label') + '<br>'.html_safe
  end

  def has_current_user?(record)
    record.has_user_id?(current_user.id) and record.users.size > 0
  end

  def link_to_if_url_exists(record)
    link_to('online', record.url) if record.has_attribute? :url and !record.url.to_s.strip.empty? and record.url =~ /^http/
  end

  def period_list_for(course)
    registered_periods = course.periods.collect {|record| record.id }
    Period.all.collect {|record| record unless registered_periods.include? record.id }.compact!
  end

  def link_to_personal_site(user, column)
    unless user.send(column).to_s.strip.empty?
      url = user.send(column) =~ /^http/ ?  user.send(column) : "http://" + user.send(column)
      link_to t(column), url, :target => '_blank'
    end
  end

  def links_for_personal_sites(user)
    %w(homepage blog calendar).collect { |column| link_to_personal_site(user, column) }.compact.join(' | ').html_safe
  end
end
