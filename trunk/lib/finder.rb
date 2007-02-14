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
          # Error, usar belongs_to
        else
          item = record.send(column)
          if item != nil then
            if item.class == Object || item.class.superclass == Object then
              content << item
            else              
              if item.attribute_names.include? 'name' 
                content << item.name  
              elsif item.attribute_names.include? 'title'
                content << item.title              
              end
            end
          end
        end
      end
    } 
    content.join(', ')
  end

  def record_content_hash(record, columns)
    content = Hash.new
    columns.each { |column|
      if column.is_a? Array then
        content << record_content_hash(record, column)
      else 
        if (column =~/_id$/)
          # Error, usar belongs_to
        else
          item = record.send(column)
          if item != nil then
            if item.class == Object || item.class.superclass == Object then
              content[column] = item
            else              
              if item.attribute_names.include? 'name' 
                content[column] = item.name  
              elsif item.attribute_names.include? 'title'
                content[column] = item.title              
              end
            end
          end
        end
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
    association = modelize(columns.first)
    myrecord = record.send(association)
    record_content(myrecord, (columns - [columns.first]))
  end
  
  def as_text
    @records.collect { |record| record_content(record, @columns) }
  end 

  def as_hash
    if @records.is_a? Array then
      [ @model.name.downcase,  @records.collect { |record| 
        record_content_hash(record, @columns) } 
      ]
    else
      [ @model.name.downcase, record_content_hash(@records, @columns) ]
    end
  end 

end

