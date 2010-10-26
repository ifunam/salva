class <%= class_name %>Controller < Admin::SuperCatalogController
<% for action in actions -%>
  def <%= action %>
  end

<% end -%>
end
