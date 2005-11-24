
module TableHelper
  def self.append_features(controller) #:nodoc:
	super 
    if controller.ancestors.include?(ActionController::Base) 
		controller.add_template_helper(self) 
    end
  end

  def table(collection,  options )
    case options["display"]
    when :default  then 
      render ( :partial => "/salva/list")
    end
  end
 
end
