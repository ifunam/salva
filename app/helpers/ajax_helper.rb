module AjaxHelper
  def observe_select(object, field, select, tabindex)
    observe_field("#{object}_#{field}",  :url => { :action => 'update_select', :partial => select, :tabindex => tabindex},
                  :update=> select,  :with => "'id='+value", :on => 'onchange',
                  :loading => "$('#{object}_#{field}').visualEffect('highlight'); $('downloading_list_indicator_for_#{ select}').show();",
                  :loaded =>"$('downloading_list_indicator_for_#{select}').hide()"
                  )
  end

  def  downloading_list_indicator(src, dst)
    render :partial => 'salva/downloading_list_indicator',  :locals => {:src => src, :dst => dst}
  end

  def stop_observer(dom_id)
    javascript_tag " $('#{dom_id.to_s}').stopObserving('click', String.blank);"
    #http://www.prototypejs.org/api/event/stopObserving  (Using String.blank instead nil o nothing)
  end

  def links_to_filters(links=[], tabindex=1, doomid='partial')
    links.collect { |label,partial,id|
      link_to_update_remote_partial(label, partial, tabindex, id, doomid)
    }.join(' | ')
  end

  def link_to_update_remote_partial(label, partial, tabindex, id=nil, doomid="partial")
    options ="'partial=#{partial}&tabindex=#{tabindex}"
    options += "&id=#{id}" if id !=nil
    options += "'"
    link_to_remote(label, :update => doomid, :url => { :action => :update_select},
                   :with => options)
  end
end
