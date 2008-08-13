require 'finder'
require 'select_helper'
require 'application_helper'
require 'labels'
class LabellingFormBuilder < ActionView::Helpers::FormBuilder
  helpers = field_helpers +  %w(date_select datetime_select time_select simple_select select_conditions radio_buttons) -   %w(hidden_field label fields_for)
  include SelectHelper
  include ApplicationHelper
  include Labels

  helpers.each do |name|
    define_method(name) do |field, *args|
      options = args.last.is_a?(Hash) ? args.pop : { }
      l = (options.has_key?:field) ? options[:field] : field
      label_field = get_label(l.to_s.downcase)
      label_field = options[:label] if options.has_key? :label
      label_field += @template.content_tag(:span, '*', :class => 'required') if options.has_key? :required and options[:required] == true
      [:label, :required].each { |k| options.delete(k) }
      @template.content_tag(:p, label(field, label_field, {:escape => false}) + super(field, options))
    end
  end

end
