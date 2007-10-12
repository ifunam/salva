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
    @sql = (opts.has_key? :attributes) ? build_sql(opts) : @sql = build_simple_sql(set_attributes, opts)
  end

  def build_sql(options)
    attributes = options[:attributes]
    select = attributes.unshift(@model)

    sql =  <<-end_sql
    SELECT #{tableize(@model)}.id AS id, #{build_select(*select)}
    FROM #{set_tables([ [ select] ]).join(', ')}
    end_sql

    sql +=  ', ' + options[:include].map{ |t| Inflector.tableize(t) }.join(', ')  if options[:include]
    sql += '    WHERE '  if build_conditions(*select).size > 0 or options[:conditions]

    if build_conditions(*select).size > 0
      sql +=  build_conditions(*select).join(' AND ')
      sql += " AND " if options[:conditions]
    end

    sql += options[:conditions]   if options[:conditions]
    sql += " ORDER BY #{options[:order]} \n" if options[:order]
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

  def build_select_array(*columns)
    columns.collect { |column|
    }.join(',')
  end

  def build_select(*columns)
    table = tableize(columns.shift)
    columns.collect { |c| (c.is_a?Array) ? build_select(*c) : "#{table}.#{c} AS #{table}_#{c}" }.compact.join(', ')
  end

  def set_table_array(*columns)
    if columns.first.is_a? Array
        set_tables(*columns).flatten
    else
      [tableize(columns.shift)]  + set_tables(*columns)
    end
  end

  def set_tables(*columns)
    columns.collect { |c| set_table_array(*c).flatten if c.is_a? Array }.compact.flatten
  end

  def build_conditions(*columns)
    table = tableize(columns.shift)
    columns.collect { |c|   ["#{table}.#{Inflector.classify(c.first).foreign_key} = #{tableize(c.first)}.id "] + build_conditions(*c).flatten if c.is_a? Array }.compact.flatten
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
     [ record.attributes.keys.reverse.collect { |column| set_string(record, column) if column != 'id' }.compact.join(', '), record.id ]
    }
  end

  def as_hash
    find_collection.collect { |record|
      [ Inflector.underscore(@model), record.attributes.keys.reverse.collect { |column| set_string(record, column) if column != 'id' }.compact.join(', ') ]
    }
  end

  def set_string(record, column)
    ( ['t', 'f', true, false].include? record.send(column) ) ? label_for_boolean(column.sub(/^([a-z0-9]_)/,''), record.send(column)) : record.send(column)
  end
end

