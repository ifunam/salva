# Finder.new(UserArticle, :attributes => [['article_id', 'title', 'authors', 'volume', 'pages', 'year',], 'ismainauthor'], :conditions => 'user_articles.user_id = 1')
require 'labels'
class Finder
  include Labels
  attr_accessor :sql
  attr_accessor :model

  def initialize(model, *options)
    @model = model
    opts = options[0] || {}
    attributes = (opts.has_key? :attributes)  ? opts[:attributes] : set_attributes
    @sql = build_sql(attributes, opts)
  end

  def build_sql(attributes, options)
    columns = [ @model, attributes ]
    columns.freeze
    sql =  <<-end_sql
    SELECT #{tableize(@model)}.id AS id, #{build_select(*columns)}
    FROM #{set_tables(*columns).join(', ')}
    WHERE #{build_conditions(*columns).join(' AND ')}
    end_sql
    sql += " AND #{opts[:conditions]}" if options[:conditions]
    sql += " ORDER BY #{opts[:order]}" if options[:order]
    sql += " LIMIT 1" if options[:first]
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

  def  set_attributes
    if @model.respond_to? 'name'
      'name'
    elsif @model.respond_to? 'title'
      'title'
    else
      '*' # ToDo: Recursive optional, because this finder help us to avoid recursive  queries.
    end
  end

  def find_collection
     @model.find_by_sql(@sql)
  end

  def as_text
    find_collection.collect { |record|
      record.attributes.keys.reverse.collect { |column| record.send(column) if column != 'id' }.compact.join(', ')
    }
  end

  def as_pair
    find_collection.collect { |record|
      [record.attributes.keys.reverse.collect { |column| record.send(column) if column != 'id' }.compact.join(', '), record.id]
    }
  end

  def as_hash
    find_collection.collect { |record|
      [ Inflector.underscore(@model), record.attributes.keys.reverse.collect { |column| record.send(column) if column != 'id' }.compact.join(', ') ]
    }
  end
end

