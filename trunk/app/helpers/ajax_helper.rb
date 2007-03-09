module AjaxHelper
  def observe_field_to_update_select(field, select, tabindex)
    observe_field("edit_#{field}", :frequency => 0.25, :url => { :action => 'update_select' }, 
                  :update=> select, :with => "'partial=#{select}&tabindex=#{tabindex}&id='+value") 
  end
end
