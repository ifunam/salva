# spec/factory.rb
require 'active_record'
require 'active_record/fixtures'
module Factory
  def self.included(base)
    base.extend(self)
  end

  def build_valid(params = {})
    unless self.respond_to?("builder_#{self.name.underscore}")
      raise "There are no default params for #{self.name}"
    end
    obj = new(self.send("builder_#{self.name.underscore}", params))
    obj.save
    obj
  end

  def build_valid!(params = {})
    obj = build_valid(params)
    obj.save!
    obj
  end

  def valid_hash(params = {})
    self.send("builder_#{self.name.underscore}", params)
  end

  def invalid_hash(params = {})
    valid_hash(params).keys.inject({}) { |h,k| h[k] = nil; h}
  end
    
  def builder_prizetype(params)
    { :name => 'Reconocimiento'
    }.merge(params)
  end

end

ActiveRecord::Base.class_eval do
  include Factory
end
