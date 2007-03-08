#Finder.new(UserArticle, [['article_id', 'title', 'authors', 'volume', 'pages', 'year',], 'ismainauthor'], 
#           :all, :conditions => ['user_id = ?', 1])
require 'labels'
class Finder
  include Labels
  attr_accessor :model
  attr_accessor :columns
  attr_accessor :records
  
  def initialize(model, columns, *options)
    @model = model
    @columns = columns
    @records = model.find(*options)
  end
  
  def record_content(record, columns)
    content = []
    columns.each { |column|
      if column.is_a? Array then
        content << record_content_array(record, column)
      elsif !record.class.reflect_on_association(column.to_sym).nil?
        content << record_content_from_belongs_to(record.send(column))
      elsif record.column_for_attribute(column).type.to_s == 'boolean'
        content << label_for_boolean(column,record.send(column))
      else
        content << record.send(column)
      end
    } 
    content.join(', ')
  end

  def record_content_from_belongs_to(record)
    if record.attribute_names.include? 'name' 
      record.send('name')  
    elsif record.attribute_names.include? 'title' 
      record.send('title')  
    else
      record_content(record, get_attributes(record)) 
    end
  end
  
  def record_content_hash(record, columns)
    content = Hash.new
    columns.each { |column|
      if column.is_a? Array then
        content[column.first] = record_content_array(record, column)
      elsif !record.class.reflect_on_association(column.to_sym).nil?
        content[column] = record_content_from_belongs_to(record.send(column))
      elsif record.column_for_attribute(column).type.to_s == 'boolean'
        content[column] = label_for_boolean(column,record.send(column))
      else
        content[column] = record.send(column) 
      end
    } 
    content
  end

  def get_attributes(record)
    attributes = []
    record.attribute_names.each { |name|
      next if %w(moduser_id created_on updated_on user_id).include? name 
      attributes << name if name !~/\w+_id$/ 
    }
    return attributes
  end

  def record_content_array(record, columns)
    model = columns.first
    if model != nil
      myrecord = record.send(model.to_sym)
      record_content(myrecord, columns - [model])
    end
  end
  
  def as_text
    if @records.is_a? Array then
      @records.collect { |record|  record_content(record, @columns)} 
    else
      [ record_content(@records, @columns) ]
    end
  end 

  def as_pair
    if @records.is_a? Array then
      @records.collect { |record|  [ record.id, record_content(record, @columns) ] }
    else
      [ [@records.id, record_content(@records, @columns) ]]
    end
  end

  def as_hash
    if @records.is_a? Array then
      [ @model.name.downcase,  @records.collect { |record|  record_content_hash(record, @columns) }  ]
    else
      [ @model.name.downcase, record_content_hash(@records, @columns) ]
    end
  end 
end

