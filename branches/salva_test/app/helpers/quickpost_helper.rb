require 'labels'
module QuickpostHelper 
  include Labels
  
  def quickpost(controller, mode='simple')
    submit_for_stack(controller) 
  end

  def submit_for_stack(controller)    
    tag :input, { "type" => "image", "src" => image_path('add.gif'), 
                   "class" => "add", "name" => 'stack', "value" => controller }
  end

  def submit_for_stack_list(controller)    
    tag :input, { "type" => "image", "src" => image_path('select.gif'), 
                   "class" => "add", "name" => 'stacklist', "value" => controller }
  end

end
