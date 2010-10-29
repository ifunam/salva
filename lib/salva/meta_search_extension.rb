module MetaSearchExtension
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def search(opts = {})
      opts.keys.each do |key|
        if key != :search_options and !self.respond_to? key
          #FIXIT: Remove this class_eval
          self.class_eval <<-METHOD, __FILE__, __LINE__ + 1
            search_methods key
            eval(#{define_method_by_prefix("#{key}")})
          METHOD
        end
      end
      super
    end
    
    protected

    def valid_method_prefixes
      %w(like_ignore_case by_difference by_soundex)
    end

    def method_prefix_valid?(name)
      valid_method_prefixes.each do |prefix|
        return true unless name.to_s.match(/\_#{prefix}$/).nil?
      end
    end

    def method_prefix(name)
      valid_method_prefixes.each do |prefix|
        return prefix unless name.to_s.match(/\_#{prefix}$/).nil?
      end
    end

    def column_name(name)
      name.to_s.sub(/\_#{method_prefix(name)}$/,'')
    end

    def column_exist?(name)
      self.column_names.include? column_name(name)
    end

    def method_valid?(method_name)
      method_prefix_valid? method_name and column_exist? method_name
    end

    def define_method_by_difference(method_name)
      %Q(scope_by_difference "#{method_name}", :fields => ["#{column_name(method_name).to_sym}"])
    end
    
    def define_method_by_soundex(method_name)
      %Q(scope_by_soundex "#{method_name}", :fields => ["#{column_name(method_name).to_sym}"])
    end

    def define_method_like_ignore_case(method_name)
      column = column_name(method_name)
      %Q(def self.#{method_name}(#{column})  
            where("LOWER(#{self.table_name}.#{column}) LIKE ?", "%\#{ #{column}.downcase}%")    
         end)
    end

    def define_method_by_prefix(method_name)
      %Q(define_method_#{method_prefix(method_name)}("#{method_name.to_sym}"))
    end
    
    def method_missing(method_name, *args)  
      if method_valid? method_name
        self.class_eval <<-METHOD, __FILE__, __LINE__ + 1
          eval(#{define_method_by_prefix("#{method_name}")}) #FIXIT: Remove this eval
        METHOD
        send(method_name, *args)
      else
        super
      end
    end
  end
end

ActiveRecord::Base.send :include, MetaSearchExtension
