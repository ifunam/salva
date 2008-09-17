# spec/factory.rb
require 'active_record'
require 'active_record/fixtures'
module Factory
  def self.included(base)
    base.extend(self)
  end
  
  
  def build_valid(params = {})
      obj = new(valid_hash(params))
      obj.save
      obj
  end
    
  def build_valid!(params = {})
    obj = build_valid(params)
    obj.save!
    obj
  end
    
  def valid_hash(params = {})
       if self.respond_to? "builder_#{self.name.underscore}"
         self.send("builder_#{self.name.underscore}", params)
       else
         fixture = "#{RAILS_ROOT}/test/fixtures/" + self.name.pluralize.underscore
         raise "There are no default data from #{fixture}[.yml|.csv]" unless File.exists?("#{fixture}.csv") or File.exists?("#{fixture}.yml")
         h = Fixtures.new(self.connection, self.name.tableize, self.name, "#{fixture}").first[1].to_hash
          %w(id created_at update_at moduser_id).each do |k| h.delete(k) end
            h.keys.each { |k| h[k] = 'test_' + h[k] if h[k].is_a? String and h[k].to_i == 0 }
            h.merge(params)
      end
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
