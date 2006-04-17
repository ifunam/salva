require 'salva_helper'
module QuickpostHelper 
  include SalvaHelper

  def quickpost(partial)
    link_to_function(image_tag('add.gif', 
                               { :border=>0, :valign => 'middle', 
                                 :alt=> get_label('add') }), 
                     toggle_effect(partial, 'Effect.BlindUp', 
                                   "duration:0.5", "Effect.BlindDown", 
                                   "duration:0.5"))    
  end
  
  def toggle_effect(domid, true_effect, true_opts, false_effect, false_opts)
    "$('#{domid}').style.display == 'none' ? new #{false_effect}('#{domid}'," +
      " {#{false_opts}}) : new #{true_effect}('#{domid}', {#{true_opts}}); " + 
      "return false;"
  end
  
  def loading_indicator_tag(scope,id)
    render(:partial => '/salva/loading_indicator_tag', 
           :locals => { :scope => scope, :id => id })
  end  
  
  def form_remote_tag_for_quickpost(controller, partial=nil, attrdiv_id=nil)
    success = "new Effect.BlindUp('"+controller+"', {duration:0.4}); " 
    success += update_select_from_quickpost(partial, attrdiv_id) if partial
    form_remote_tag(:success => success,
                    404 => "alert('Not found...? Wrong URL...?')", 
                    :loading => "AjaxScaffold.newOnLoading(request,'"+controller+"');", 
                    :failure => "alert('HTTP Error ' + request.status + '!');", 
                    :url  => { :controller => controller, :action => 'create' } )
  end

  def update_select_from_quickpost(partial, attrdiv_id=nil)
    partial_note = partial + '_note'
    params = "'partial=#{partial}&id='+$F('#{attrdiv_id}')" if attrdiv_id
    success_msg = "Effect.BlindUp('#{partial_note}', {duration: 0.5});; "
    success_msg += "return false;"
    loading_msg = "Toggle.display('#{partial_note}');"
    remote_function(:update => partial, :with => params, 
                    :url => {:action => :update_select},
                    :loading => loading_msg,
                    :success => success_msg)
  end
  
  def link_to_cancel_for_quickpost(controller)
    "<a href=\"#\" onclick=\"new Effect.BlindUp('#{controller}', {duration: 0.4}); " +
      "return false;\">"+get_label('cancel')+"</a>"
  end
end
