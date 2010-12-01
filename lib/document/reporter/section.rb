module Reporter

  class Section
    def initialize(title=nil)
      @section = Composite.new(title)
    end

    def title
      @section.title
    end

    def collection(title, options)
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
      @date_format = options[:date_format] || false
    end

    def search(options={})
      scoped_class.search(options).all.collect do |record|
        record.respond_to?(:as_text) ? record.as_text : "Define as_text method in #{record.class}"
      end
    end

    def date_format?
      @date_format
    end

    private
    def class_name
      @class_name.to_s.classify.constantize
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
