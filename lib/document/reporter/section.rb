module Reporter

  class Section
    def initialize(title=nil)
      @section = Composite.new(title)
    end

    def title
      @section.title
    end

    def collection(title, options={})
      add_child(Leaf.new title, options)
    end

    def add_child(child)
      @section.add_child(child)
    end

    def sections
      @section.children
    end
  end

  class Leaf
    attr :title, :reader
    def initialize(title, options={})
      @title = title
      @class_name = options[:class_name] || title
      @scope = options[:scope]
      @date_style = options[:date_style] || :month_and_year
    end

    def search(options={})
      scoped_class.search(options).all.collect do |record|
        record.respond_to?(:to_s) ? normalize_text(record.to_s) : "Define to_s method in #{record.class}"
      end
    end

    def all
      scoped_class.all.collect do |record|
       record.respond_to?(:to_s) ? normalize_text(record.to_s) : "Define to_s method in #{record.class}"
      end
    end

    def normalize_text(string)
      string.gsub(/\r\n/,'').sub(/\n{1}+/,"\n").sub(/\r{1}+/,"\r").sub(/^('|"|`|\s)+/, '').sub(/('|"|`|\s|,|;)+$/, '').sub(/\s{1}+/, ' ')
    end

    # date_style: This method is useful to know what search options must be used in the reporter
    def date_style
      @date_style if [:date, :date_range, :month_and_year, :only_year, :date_disabled, :month_and_year_range].include? @date_style.to_sym
    end

    private
    def class_name
      @class_name.to_s.pluralize.singularize.camelize.constantize
    end

    def scope
      @scope.to_s unless @scope.nil?
    end

    def scoped_class
      @scope.nil? ? class_name : class_name.send(scope)
    end
  end

  class Composite
    attr_reader :title, :children

    def initialize(title=nil)
      @title = title unless title.nil?
      @children = []
    end

    def add_child(child)
      children << child
    end

    def remove_child(child)
      children.delete child
    end
  end

end
