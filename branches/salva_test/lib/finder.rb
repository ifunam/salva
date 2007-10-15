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
    @sql = (opts.has_key? :attributes) ? build_sql(opts) : @sql = build_simple_sql(set_attributes(@model).join(', '), opts)
  end

  def build_sql(options)
    columns = extract_attributes_from_array(@model, options[:attributes])
    columns.unshift(Inflector.tableize(@model).classify)

    sql = "SELECT #{tableize(@model)}.id AS id, #{build_select(*columns)} FROM #{set_tables([ [ columns] ]).uniq.join(', ')}"

    add_tables!(sql, options)
    add_conditions!(sql, options, columns)
    add_limit!(sql, options)
    clean_sql!(sql)
  end

  def build_simple_sql(attributes, options)
    attributes = options[:column] if options.has_key? :column
    sql =  "SELECT id, #{attributes} FROM #{tableize(@model)}"
    add_conditions!(sql, options)
    add_order!(sql, options, attributes)
    add_limit!(sql, options)
    clean_sql!(sql)
  end

  def add_tables!(sql, options)
    sql << ', ' + options[:include].map{ |t| tableize(t) }.uniq.join(', ')  if options[:include]
  end

  def add_conditions!(sql, options, columns=[])
    sql << ' WHERE '  if build_conditions(*columns).size > 0 or options[:conditions]
    if build_conditions(*columns).size > 0
      sql << build_conditions(*columns).join(' AND ')
      sql << " AND " if options[:conditions]
    end
    sql << options[:conditions]   if options[:conditions]
  end

  def add_order!(sql, options, attributes=nil)
    if !attributes.nil?
      order = (options.has_key? :order ) ? " ORDER BY options[:order]" : " ORDER BY #{attributes} ASC"
      sql << order
    else
      sql << " ORDER BY #{options[:order]} " if options[:order]
    end
  end

  def add_limit!(sql, options)
    limit = options[:first] ? 1 : options[:limit]
    sql << " LIMIT #{limit}" if limit.to_i > 0
  end

  def clean_sql!(sql)
    sql.gsub(/\n/, '').gsub(/(\s)+/, " ").strip
  end

  def build_select(*columns)
    table = tableize(columns.shift)
    columns.collect { |c| (c.is_a?Array) ? build_select(*c) : "#{table}.#{c} AS #{table}_#{c}" }.compact.join(', ')
  end

  def set_tables(*columns)
    columns.collect { |c| set_table_array(*c).flatten if c.is_a? Array }.compact.flatten
  end

  def set_table_array(*columns)
    (columns.first.is_a? Array) ? set_tables(*columns).flatten : [tablename(tableize(columns.shift))]  + set_tables(*columns)
  end

  def tablename(t)
    (table_exists? t) ? t : "#{t.sub(/^\w+\_/, '')} AS #{t}"
  end

  def table_exists?(t)
    # Replace this code for something: ModelClass.exists?
    @model.find_by_sql("SELECT tablename AS id FROM pg_tables WHERE schemaname = 'public' AND tablename = '#{t}'").size == 1 ? true : false
  end

  def build_conditions(*columns)
    table = tableize(columns.shift)
    columns.collect { |c|
      ["#{table}.#{Inflector.foreign_key(c.first)} = #{tableize(c.first)}.id "] + build_conditions(*c).flatten if c.is_a? Array  and  table !=  tableize(c.first)
    }.compact.flatten
  end

  def set_attributes(m, recursive=false)
    model = modelize(clean_model!(m))
    attributes = [ ]
    if column_names(model).include? 'name'
      attributes = ['name']
    elsif column_names(model).include? 'title'
      attributes = ['title']
    else
      attributes = (recursive == true) ?  expand_attributes(model) :  column_names(model)
    end
    attributes
  end

  def expand_attributes(model)
    column_names(model).collect { |column|
      if column =~ /\_id$/
        mymodel =  column.sub(/\_id$/,'')
        model_and_attributes(mymodel)
      else
        column
      end
    }.compact
  end

  def extract_attributes_from_array(model, attributes)
    attributes.collect { |a|
      next if a.class == Class
      (a.is_a? Array) ? extract_array_attributes(model, a) :   extract_simple_attributes(model, a)
    }.compact
  end

  def extract_array_attributes(model, attribute)
    if attribute.size == 1
      model_and_attributes(clean_model(attribute.first))
    elsif modelize(clean_model!(attribute.first)) == model
      clean_model!(attribute)
    else
      extract_attributes_from_array(clean_model!(attribute.first), attribute)
    end
  end

  def extract_simple_attributes(model, attribute)
    if column_names(model).include? "#{attribute}_id"
      model_and_attributes(clean_model!(attribute))
    else
     attribute
    end
  end

  def clean_model!(model)
    ( model.is_a? String and model =~ /^\w+\_/) ? model.sub(/^\w+\_/, '')  : model
  end

  def tableize(column)
    Inflector.tableize(column).pluralize
  end

  def modelize(m)
    Inflector.tableize(m).classify.constantize
  end

  def column_names(m)
    modelize(m).column_names  - %w(id moduser_id created_on updated_on user_id)
  end

  def model_and_attributes(model)
    set_attributes(model, true).unshift(model)
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


