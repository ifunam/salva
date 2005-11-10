require 'once'

module ModelSecurityHelper
end

module ActiveRecord
  class Base
    once('@modelSecurityInstanceAliasesDone') {
      # Provides access to the pre-overload version of read_attribute, which
      # is called by the overloaded version.
      alias :old_read_attribute :read_attribute
  
      # Provides access to the pre-overload version of write_attribute, which
      # is called by the overloaded version.
      alias :old_write_attribute :write_attribute
    }

    def readable?(name)
      true
    end

    def writable?(name)
      true
    end

    class << self
    private
      once('@modelSecurityClassAliasesDone') {
        # Provides access to the pre-overload version of content_columns, which
        # is called by the overloaded version.
        alias :old_content_columns :content_columns
      }
    public
      # Overload the base method to understand the let_display directive
      # of ModelSecurity. If display? is not true for a model attribute
      # in this context, that attribute won't be reported as a content
      # column.
      def content_columns
        old_content_columns.reject { |c|
          not display?(c.name)
        }
      end

      # Always return true. ModelSecurity.display? will override this.
      def display?(name)
        true
      end
    end
  end
end

module ActionView
  module Helpers
    # Overload the form helper functions to understand ModelSecurity and
    # act upon the permissions that ModelSecurity encodes. If a model
    # attribute does not have a read permission in the current context,
    # its data won't be displayed, or read at all, and thus the helpers
    # won't trigger a ModelSecurity exception.  If there's no write
    # permission on the datum, you'll display static data instead of an
    # edit field. Write-only attributes work too. And all of this works
    # on scaffolds.
    # 
    # The methods overriden here are:
    # 
    # * check_box
    # * file_field
    # * hidden_field
    # * password_field
    # * radio_button
    # * text_area
    # * text_field
    #
    module FormHelper
    private
    
      def self.restrict(name)
        module_eval <<-"end_eval", __FILE__, __LINE__
          private
	  alias :old_#{name} :#{name}
          def #{name}(object, method, options = {})
            restricted_input('#{name}', object, method, options)
          end
        end_eval
      end
    
      def restricted_input(function, object, method, options, *extra, &block)
        o = instance_variable_get('@' + object)

        if o.readable?(method)
          if o.writable?(method) # Read+Write
            if block
              return yield(object, method, options, extra)
            else
              return send(('old_' + function).to_sym, object, method, options)
            end
          else # Read Only
            return o.send(method)
          end
        else # Not Readable.
          if o.writable?(method) # Write only.
            u = { :value => '' }

            return send(('old_' + function).to_sym, object, method, options.update(u))
          else # Neither readable or writable.
            return ''
          end
        end
      end
    
      # Evaluating the aliases twice would break them.
      # Evaluating the constant definition twice causes a complaint.
      once ('@modelSecurityAliasesDone') {
        alias :old_check_box :check_box
        alias :old_radio_button :radio_button
      }
    
    
    public
    
      once ('@simpleMethodsDone') { # because it calls alias.
        m = %w(file_field hidden_field password_field text_area text_field)

        m.each { | name | restrict(name) }
      }
    
      def check_box(object, method, options = {}, checked_value = "1", unchecked_value = "0") #:nodoc:
        restricted_input('check_box', object, method, options, checked_value, unchecked_value) {
          | object, method, options, extra |
          old_check_box(object, method, options, extra[0], extra[1])
        } 
      end
    
      def radio_button(object, method, tag_value, options = {}) #:nodoc:
        restricted_input('radio_button', object, method, options, tag_value) {
          | object, method, options, extra |
          old_radio_button(object, method, extra[0], options)
        }
      end
    end
  end
end
