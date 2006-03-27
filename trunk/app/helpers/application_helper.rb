# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper 
  def head_title 
    "#{@controller.controller_class_name} : #{@controller.action_name}" 
  end   

  def action_link(action, id, alt, question=nil)
    image ='/images/invisible_16x16.png'
    miceover = "return overlib('#{alt}', WIDTH, 20, HEIGHT, 20, RIGHT, BELOW, "
    miceover += "SNAPX, 2, SNAPY, 2)"
    miceout = "return nd()" 
    link_options = { :action => action, :id => id}
    html_options = { :class => action, :onmouseover => miceover, 
                     :onmouseout => miceout }
    html_options[:confirm] = question if question != nil
    
    link_to(image_tag(image, :size => '16x16', :border => 0, :alt => alt), 
            link_options, html_options )
  end
  
  def show_link(id)
    action_link('show', id, 'Mostrar')
  end
  
  def edit_link(id)
    action_link('edit', id, 'Modificar')
  end
  
  def purge_link(id,question)
    action_link('purge', id, 'Borrar', question)
  end

  def check_box(object, id, checked=false, prefix='item_id')
    check_box_tag("#{object}[#{prefix}][]", id, checked = false, 
                  options = {:id => prefix}) 
  end
  
  def check_box_group(object, model, options={})
    options = options.stringify_keys
    prefix = model.name.downcase+'_id'      
    if options['prefix'] then
      prefix = options['prefix']+'_'+model.name.downcase+'_id'
    end
    ckbox_group = "<ul>\n"
    model.find(:all, :order => 'name ASC').collect { |m| 
      ckbox_group += '<li>' + check_box_tag("#{object}[#{prefix}][]", m.id, checked = false, options = {:id => prefix})  + m.name + "</li>\n"
    }
    ckbox_group += "</ul>\n"
    ckbox_group
  end
  
  def quickpost(partial)
    link_to_function(image_tag('add.gif', {:border=>0, :valign => 'middle', :alt=> 'Agregar'}), toggle_effect(partial, 'Effect.BlindUp', "duration:0.4", "Effect.BlindDown", "duration:0.4"))    
  end

  def toggle_effect(domid, true_effect, true_opts, false_effect, false_opts)
    "$('#{domid}').style.display == 'none' ? new #{false_effect}('#{domid}', {#{false_opts}}) : new #{true_effect}('#{domid}', {#{true_opts}}); return false;"
  end
  
  # This can be moved into application_helper.rb
  def loading_indicator_tag(scope,id)
    "<img src=\"/images/indicator.gif\" style=\"display: none;\" id=\"#{scope}-#{id}-loading-indicator\" alt=\"loading indicator\" class=\"loading-indicator\" />"
  end  
end 
