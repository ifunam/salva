require 'active_record'

class ActiveRecord::Base
  def dom_id(postfix=nil, *args)
    display_id = new_record? ? "new" : id
    self.class.dom_id(display_id, postfix, *args)
  end
  
  class << self
      def dom_id(id=nil, postfix=nil, *args)
        display_id = id || "new"
        dom_join(self.name.underscore, display_id, postfix, *args)
      end
      
      # isolating decision to use '-'
      def dom_join(*args)
        args.compact.join('-')
      end
  end
end

module DashedDomIdHelper
    def dom_id(*args)
        args.collect {|x| 
            if x.respond_to? :dom_id
                x.dom_id 
            elsif x.respond_to? :name
                x.name.underscore 
            else
                x
            end
        }.join('-')
    end
end

module ApplicationHelper
  include DashedDomIdHelper
end

