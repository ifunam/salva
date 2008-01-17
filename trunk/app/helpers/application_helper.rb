# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def head_title
    "#{@controller.controller_class_name} : #{@controller.action_name}"
  end

  def action_link(action, id, alt, question=nil, controller=nil)
    image ='/images/invisible_16x16.png'
    miceover = "return overlib('#{alt}', WIDTH, 20, HEIGHT, 20, RIGHT, BELOW, "
    miceover += "SNAPX, 2, SNAPY, 2)"
    miceout = "return nd()"
    link_options = { :action => action, :id => id}
    link_options[:controller] = controller if  controller != nil
    html_options = { :class => action, :onmouseover => miceover,
                     :onmouseout => miceout }
    html_options[:confirm] = question if  question != nil

    link_to(image_tag(image, :size => '16x16', :border => 0, :alt => alt),
            link_options, html_options )
  end

  def text_link(text, id, controller=nil)
    link_options = { :action => 'edit', :id => id}
    link_options[:controller] = controller if  controller != nil
    link_to(text, link_options)
  end

  def show_link(id,controller=nil)
    action_link('show', id, 'Mostrar', nil, controller)
  end

  def edit_link(id,controller=nil)
    action_link('edit', id, 'Modificar', nil, controller)
  end

  def purge_link(id,question,controller=nil)
    action_link('purge', id, 'Borrar', question, controller)
  end

  def controller_link(child_controller,parent_controller,parent_action,key,id)
    link_to('Seleccionar',
            { :controller => child_controller, :action => 'list',
              :parent_controller => parent_controller,
              :parent_action => parent_action, :key => key,
              :id => id
            } )
  end

  def link_to_searchdialog(label,partial)
    params = "'partial=#{partial}'"
    success_msg = "new Effect.BlindUp('search_note', {duration: 0.5}); "
    success_msg += "return false;"
    loading_msg = "Toggle.display('search_note');"
    link_to_function(label,
                     remote_function(:update => 'search', :with => params,
                                     :url => {:action => :update_searchdialog},
                                     :loading => loading_msg,
                                     :success => success_msg)
                     )
  end

  def hidden_tag(object, model, name, field=nil)
    hidden_field(object, foreignize(model), :value => modelid(model, name))
  end

  def modelid(model, name)
    model.find_by_name(name).id
  end
  
  def foreignize(model, prefix=nil)
    (prefix != nil) ? prefix + '_' +  Inflector.foreign_key(model) : Inflector.foreign_key(model)
  end
end
