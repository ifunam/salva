module AjaxHelper
  def observe_select(field, select, tabindex)
    observe_field("edit_#{field}", :frequency => 0.25, :url => { :action => 'update_select', :partial => select, :tabindex => tabindex}, :update=> select,  :with => "'id='+value", :on => 'click')
  end

  def stop_observer(field)
    javascript_tag " $('edit_#{field}').stopObserving('click', String.blank);"
    #http://www.prototypejs.org/api/event/stopObserving  (Using Strin.blank instead nil o nothing)
  end

  def links_to_filters(model, buttons = [])
    buttons.collect { |key,value|
      link_to_update_remote_partial(key, value)
    }.join(' | ')
  end

  def link_to_update_remote_partial(label, partial)
    link_to_remote(label, :update => "partial", :url => { :action => :update_remote_partial}, :with => "'partial=#{partial}'")
  end
end
