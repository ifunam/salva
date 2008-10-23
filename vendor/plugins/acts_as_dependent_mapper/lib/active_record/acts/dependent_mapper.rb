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
            cattr_accessor :sequence
            self.sequence = options[:sequence]
          end
        end

        end
        module InstanceMethods
           def get_sequence
             self.sequence
           end

          def set_attributes
          end
        end

    end
  end
end

