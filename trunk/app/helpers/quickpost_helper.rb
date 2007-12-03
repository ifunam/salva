 require 'labels'
module QuickpostHelper
  include Labels

  def quickpost(controller)
    tag :input, { "type" => "submit", "class" => "quickpost", 
    	          "name" => 'stack', "value" => controller }
  end

  def submit_for_stack_list(controller)
    ('&nbsp;' * 15) + (tag :input, { "type" => "submit", "class" => "quickpost-select", "name" => 'stacklist', "value" => controller })
  end

end
