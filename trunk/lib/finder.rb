#Finder.new(UserArticle, [['article_id', 'title', 'authors', 'volume', 'pages', 'year',], 'ismainauthor'], 
#           :all, :conditions => ['user_id = ?', 1])


class Finder
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
      else 
        if (column =~/_id$/)
          content << record_content_from_association(record, column)
        else
          content << record.send(column) if record.send(column) != nil
        end
        
      end
    } 
    content.join(', ')
  end

  def record_content_from_association(record, column)
    association = modelize(column)
    case record.class.reflect_on_association(association.to_sym).macro
    when :has_one, :belongs_to
      record_content_from_belongs_to(record,association)
    end
  end
  
  def record_content_from_belongs_to(record, association)
    if record.send(association).attribute_names.include? 'name' 
      record.send(association).send('name')  
    elsif record.send(association).attribute_names.include? 'title' 
      record.send(association).send('title')  
    else
      myrecord = record.send(association)
      record_content(myrecord, get_attributes(myrecord)) 
    end
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
    association = modelize(columns.first)
    myrecord = record.send(association)
    record_content(myrecord, (columns - [columns.first]))
  end
  
  def list_collection
    @records.collect { |record| record_content(record, @columns) }
  end  
  
  def as(style)
    #...
  end

  private
  def modelize(column)
    Inflector.tableize(column.sub(/_id$/,'')).singularize
  end    
end

