require 'salva_helper'
module QuickpostHelper 
  include SalvaHelper
  
  def quickpost(partial,mode='simple')
    if mode  == 'simple'
      link_to_function(image_tag('add.gif', { :border=>0, :valign => 'middle', :alt=> get_label('add') }), 
                       toggle_effect(partial, 'Effect.BlindUp',  "duration:0.5", "Effect.BlindDown", "duration:0.5"))    
    else
      link_to(image_tag('add.gif', { :border=>0, :valign => 'middle', :alt=> get_label('add') }), 
              { :action => "stack", :handler => partial })
    end
  end
  
  def toggle_effect(domid, true_effect, true_opts, false_effect, false_opts)
    "$('#{domid}').style.display == 'none' ? new #{false_effect}('#{domid}'," +
      " {#{false_opts}}) : new #{true_effect}('#{domid}', {#{true_opts}}); " + 
      "return false;"
  end

  def form_remote_tag_for_quickpost(controller, partial, attribute)
    form_remote_tag(:success => "new Effect.BlindUp('"+controller+"', {duration:0.4});; ",
                    404 => "alert('Not found...? Wrong URL...?')", 
                    :loading => "AjaxScaffold.newOnLoading(request,'"+controller+"');", 
                    :failure => "alert('HTTP Error ' + request.status + '!');", 
                    :url  => { :controller => controller, :action => 'create' }
                    )
  end

  def reset_select(label,partial,div_to_update)
    note =  div_to_update + "_note"
    success_msg = "Effect.BlindUp('#{note}', {duration: 0.5});; "
    success_msg += "return false;"
    loading_msg = "Toggle.display('#{note}');"
    link_to_remote(label, :update => div_to_update, :with => "'partial=#{partial}'", :url => {:action => :update_select},
                   :loading => loading_msg, :success => success_msg)
  end
  
  def update_select_from_quickpost(partial, attrdiv_id=nil)
    partial_note = partial + '_note'
    params = "'partial=#{partial}&id='+$F('#{attrdiv_id}')" if attrdiv_id
    remote_function(:url => {:action => :update_select},
                    :success => "Effect.BlindUp('#{partial}_note}', {duration: 0.4);;")
  end
  
  def loading_indicator_tag(scope,id)
    render(:partial => '/salva/loading_indicator_tag', 
           :locals => { :scope => scope, :id => id })
  end  
  
  def submit_remote_tag_for_quickpost(controller, partial, attribute)
    success = update_select_from_quickpost(partial,attribute) 
  end
  
  def link_to_cancel_for_quickpost(controller)
    "<a href=\"#\" onclick=\"new Effect.BlindUp('#{controller}', {duration: 0.4}); " +
      "return false;\">"+get_label('cancel')+"</a>"
  end
end
