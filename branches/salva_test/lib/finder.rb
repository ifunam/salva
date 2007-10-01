#Finder.new(UserArticle, [['article_id', 'title', 'authors', 'volume', 'pages', 'year',], 'ismainauthor'],  :all, :conditions => 'user_articles.user_id = 1')
require 'labels'
class Finder
  include Labels
  attr_accessor :sql
  attr_accessor :model

  def initialize(model, columns, *options)
    @model = model
    args = [model,  columns]
    args.freeze
    opts = options.size > 1 ? options[1]  : {}
    @sql = "SELECT #{tableize(model)}.id AS id, #{columns_for_select(*args)} FROM #{get_tables(*args).join(', ')}  WHERE #{set_conditions(*args).join(' AND ')}"
    @sql += " AND #{opts[:conditions]}" if opts[:conditions]
    @sql += " ORDER BY #{opts[:order]}" if opts[:order]
    @sql += " LIMIT 1" if opts[:first]
  end

  def tableize(column)
    Inflector.tableize(column).pluralize
  end

  def columns_for_select(*columns)
    table = tableize(columns.first)
    columns.shift
    columns.collect { |column|
      if column.is_a?Array
        columns_for_select(*column)
      else
        "#{table}.#{column} AS #{table}_#{column}"
      end
    }.join(', ')
  end

  def get_tables(*columns)
    tables= [ tableize(columns.first) ]
    columns.shift
    columns.collect { |c|
      if c.is_a?Array
        tables += get_tables(*c)
      end
    }
    tables
  end

  def set_conditions(*columns)
    table = tableize(columns.first)
    columns.shift
    conditions = []
    columns.collect { |column|
      if column.is_a?Array
        conditions << "#{table}.#{Inflector.classify(column.first).foreign_key} = #{tableize(column.first)}.id "
        conditions += set_conditions(*column)
      end
    }
    conditions
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

