module AjaxHelper
  def observe_field_to_update_select(field, select, tabindex)
    observe_field("edit_#{field}", :frequency => 0.25, :url => { :action => 'update_select' }, 
                  :update=> select, :with => "'partial=#{select}&tabindex=#{tabindex}&id='+value") 
  end

  def link_to_update_remote_partial(label, partial)
    link_to_remote(label, :update => "partial", :url => { :action => :update_remote_partial}, :with => "'partial=#{partial}'")
  end
end
