  module ActiveRecord
  module Acts
    module DependentMapper

      def self.included(base)
        base.extend(ClassMethods)
      end

      module ClassMethods
        def acts_as_dependent_mapper(options = {})
          class_eval do
            include ActiveRecord::Acts::DependentMapper::InstanceMethods
            cattr_accessor :sequence, :dependent_records
            self.sequence = options[:sequence]
            self.dependent_records = {}
            attr_protected :sequence
            # :dependent_records
          end
        end
      end

      module InstanceMethods
        def set_attributes_from(params)
          owner = ActiveSupport::Inflector.underscore(self.class)
          update_attributes(self, params[owner]) unless params[owner].nil?
          if self.new_record?
            mapper_for_new_record(self, self.sequence, params)
          else
            mapper_for_existent_record(self, self.sequence, params)
          end
        end

        def save
          sequence_mapper(self, self.sequence) if self.new_record?
          super
        end
        
        def self.find(*args)
          existent_record_loader(self, self.sequence)
          super
        end
        private

        def record_loader(key, params)
          model_klass = ActiveSupport::Inflector.classify(key).constantize
          model_klass.exists?(params) ? model_klass.first(:conditions => params) : model_klass.new(params)
        end

        def sequence_mapper(parent, sequence)
          sequence.each do |model|
            if model.is_a? Array
              sequence_mapper(parent, model)
            else
              unless self.dependent_records[model].nil?
                parent.send("#{model.to_s}=", self.dependent_records[model])
                parent = self.dependent_records[model]
              end
            end
          end
        end

        def mapper_for_new_record(parent, sequence, params)
          sequence.flatten.each do |key|
            self.dependent_records[key] = record_loader(key, params[key.to_s]) unless params[key.to_s].nil? 
          end 
        end

        def mapper_for_existent_record(parent, sequence, params)
          sequence.each do |model|
            if model.is_a? Array
              mapper_for_existent_record(parent, model, params)
            else
              update_attributes(parent.send(model), params[model.to_s])
              self.dependent_records[model] = parent.send(model) unless params[model.to_s].nil? 
              parent = parent.send(model)
            end
          end 
        end

        def update_attributes(model, attributes)
          attributes.keys.each do |a|
            model.[]=(a, attributes[a]) if self.has_attribute? a
          end
        end
        
        def existent_record_loader(parent, sequence)
          sequence.each do |model|
            if model.is_a? Array
              existent_record_loader(parent, model)
            else
              self.dependent_records[model] = parent.send(model) 
              parent = parent.send(model)
            end
          end 
        end
      end
    end
  end
end

