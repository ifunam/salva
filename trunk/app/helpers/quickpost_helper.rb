require 'labels'
module QuickpostHelper 
  include Labels
  
  def quickpost(controller, mode='simple')
    submit_for_stack(controller) 
  end

  def submit_for_stack(controller)    
    image_submit_tag('/images/add.gif', {:name => 'stack', :value => controller })
  end

end
