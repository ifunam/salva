module AjaxHelper
  def observe_field_to_update_select(field, select, tabindex)
    observe_field("edit_#{field}", :frequency => 0.25, :url => { :action => 'update_select' }, 
                  :update=> select, :with => "'partial=#{select}&tabindex=#{tabindex}&id='+value", :on => 'click') 
  end

  def link_to_update_remote_partial(label, partial)
    link_to_remote(label, :update => "partial", :url => { :action => :update_remote_partial}, :with => "'partial=#{partial}'")
  end


  def links_to_filters(model, buttons = [])
    buttons.collect { |key,value|
      link_to_update_remote_partial(key, value)
    }.join(' | ')
  end

end
