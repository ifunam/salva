# Finder.new(UserArticle, :attributes => [['article', 'title', 'authors', 'volume', 'pages', 'year',], 'ismainauthor'], :conditions => 'user_articles.user_id = 1')
# OR
# Finder.new(UserArticle, :all, :attributes => [['article', 'title', 'authors', 'volume', 'pages', 'year',], 'ismainauthor'], :conditions => 'user_articles.user_id = 1')
# 
# Finder.new(UserArticle, :first, :attributes => [['article', 'title', 'authors', 'volume', 'pages', 'year',], 'ismainauthor'], :conditions => 'user_articles.user_id = 1')
#
# Finder.new(Article) == Finder.new(Article, :all)
# Finder.new(Country) == Finder.new(Country, :all)
# Finder.new(Country, :first)
# Finder.new(Journal)

require 'labels'
class Finder
  include Labels
  attr_accessor :sql
  attr_accessor :model

  def initialize(model, *options)
    opts = (options[0].is_a? Hash) ? options[0] : (options[1] || {})
    opts[:first] = true if options[0] == :first
    @model = model
    @sql = (opts.has_key? :attributes) ? build_sql(opts[:attributes], opts) : @sql = build_simple_sql(set_attributes, opts)
  end
  
  def build_sql(attributes, options)
    columns = [ @model, attributes ]
    columns.freeze
    sql =  <<-end_sql
    SELECT #{tableize(@model)}.id AS id, #{build_select(*columns)}
    FROM #{set_tables(*columns).join(', ')}
    WHERE #{build_conditions(*columns).join(' AND ')}
    end_sql
    sql += " AND #{options[:conditions]}" if options[:conditions]
    sql += " ORDER BY #{options[:order]}" if options[:order]
    limit = options[:first] ? 1 : options[:limit]
    sql += " LIMIT #{limit}" if limit.to_i > 0
    sql
  end

  def build_simple_sql(attributes, options)
    attributes = options[:column] if options.has_key? :column
    sql =  "SELECT id, #{attributes}  FROM #{tableize(@model)}"
    sql += " WHERE #{options[:conditions]}" if options[:conditions]
    sql += (options.has_key? :order ) ? " ORDER BY options[:order]" : " ORDER BY #{attributes} ASC"
    limit = options[:first] ? 1 : options[:limit]
    sql += " LIMIT #{limit}" if limit.to_i > 0
    sql
  end

  def tableize(column)
    Inflector.tableize(column).pluralize
  end

  def build_select(*columns)
    table = tableize(columns.shift)
     columns.collect { |column|  (column.is_a?Array) ?  build_select(*column) : "#{table}.#{column} AS #{table}_#{column}" }.join(', ')
  end

  def set_tables(*columns)
    tables = [ tableize(columns.shift) ]
    columns.collect { |c| tables += set_tables(*c) if c.is_a?Array  }
    tables
  end

  def build_conditions(*columns)
    table = tableize(columns.shift)
    conditions = []
    columns.collect { |column|
      if column.is_a?Array
        conditions << "#{table}.#{Inflector.classify(column.first).foreign_key} = #{tableize(column.first)}.id "
        conditions += build_conditions(*column)
      end
    }
    conditions
  end

  def set_attributes
    attributes = [ ]
    if @model.column_names.include? 'name'
      attributes << 'name'
    elsif @model.column_names.include? 'title'
      attributes << 'title'
    else
      attributes += @model.column_names  - %w(id moduser_id created_on updated_on user_id)
    end
    attributes.join(', ')
  end

  def find_collection
     @model.find_by_sql(@sql)
  end

  def as_text
    find_collection.collect { |record|
      record.attributes.keys.reverse.collect { |column| set_string(record, column) if column != 'id' }.compact.join(', ')
    }
  end

  def as_pair
    find_collection.collect { |record|
      [record.attributes.keys.reverse.collect { |column| set_string(record, column) if column != 'id' }.compact.join(', '), record.id]
    }
  end

  def as_hash
    find_collection.collect { |record|
      [ Inflector.underscore(@model), record.attributes.keys.reverse.collect { |column| set_string(record, column) if column != 'id' }.compact.join(', ') ]
    }
  end

  def set_string(record, column)
    record.send(column) == (true || false) ? label_for_boolean(column.sub(/^([a-z0-9]_)/,''), record.send(column)) : record.send(column)
  end
end

