# This module extends the MetaSeach plugin to generate methods based 
# on _like_ignore_case, by_soundex and by_difference prefixes.
module Salva::MetaSearchExtension
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def search(opts = {})
      #TODO: Refactor this block
      opts ||= {}
      opts.keys.each do |key|
        if key != :search_options and !self.respond_to? key and method_name_valid? key
          self.class_eval <<-METHOD, __FILE__, __LINE__ + 1
          # search_methods key
          eval(#{define_method_by_prefix("#{key}")})
          METHOD
        end
      end
      super
    end

    protected

    def method_prefix_valid?(name)
      !name.to_s.match(/(like_ignore_case|by_difference|by_soundex)$/).nil?
    end

    def method_prefix(name)
      name.to_s.match(/(like_ignore_case|by_difference|by_soundex)$/)[1]
    end

    def column_name(name)
      name.to_s.gsub(/_(like_ignore_case|by_difference|by_soundex)$/,'')
    end

    def column_exist?(name)
      self.column_names.include?(name)
    end

    def method_name_valid?(method_name)
      method_prefix_valid? method_name.to_s and column_exist? column_name(method_name)
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
          where("LOWER(#{table_name}.#{column}) LIKE ?", "%\#{ #{column}.downcase}%")    
         end)
    end

    def define_method_by_prefix(method_name)
      %Q(define_method_#{method_prefix(method_name)}("#{method_name.to_sym}"))
    end
  end
end

ActiveRecord::Base.send :include, Salva::MetaSearchExtension
