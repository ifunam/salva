module ComposedKeys
  def self.append_features(base)
    super
    base.extend(ClassMethods)
  end
  
  module ClassMethods
    def set_primary_keys(*keys)
      cattr_accessor :primary_keys 
      cattr_accessor :reserved_attributes
      self.primary_keys = keys.collect {|key| key.to_s}
      self.reserved_attributes = %w(created_on updated_on)
    end
  end
end

require 'active_record'
ActiveRecord::Base.class_eval do
  include ComposedKeys
end

