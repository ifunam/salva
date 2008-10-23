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
            cattr_accessor :sequence, :foreign_key

            self.sequence = options[:sequence]
            self.foreign_key = options[:foreign_key]

            attr_protected :sequence, :foreign_key
          end
        end

        end
        module InstanceMethods

          def set_attributes
          end
        end

    end
  end
end

