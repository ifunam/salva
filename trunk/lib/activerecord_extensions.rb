require 'labels'
module ActiveRecordExtensions
  include Labels
  def as_text
    record_content(self, get_attributes(self)).gsub(', ,', '')
  end

  def get_attributes(record, n=nil)
    attributes =  record.attribute_names.collect { |attribute|
      next if %w(id user_id moduser_id created_on updated_on).include?  attribute
      attribute
    }.compact
    # Queda pendiente definir el criterio para obtener atributos..
    n.nil? ? attributes :  attributes.first(n)
  end

  def record_content(record, columns, n=0)
    return '' if record.nil?
    content = []
    columns.each { |column|
      if column =~/\w+_id$/
        content << record_from_belongs(record.send(column.sub(/_id$/,'')), n += 1)  if n < 3
      elsif record.column_for_attribute(column).type.to_s == 'boolean'
        content << get_label(column) + ': ' + label_for_boolean(column,record.send(column))
      else
        content << record.send(column)
      end
     }
    content.compact.join(', ')
  end

  def record_from_belongs(record,n)
    if !record.nil?
      record_content(record, get_attributes(record), n)
    end
  end
end

module Timestamped
  def self.append_features(base)
    base.before_create do |model|
      model.created_on ||= Time.now if model.respond_to?(:created_on)
    end

    base.before_save do |model|
      model.updated_on = Time.now if model.respond_to?(:updated_on)
    end
  end
end
