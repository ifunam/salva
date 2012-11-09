module NavigationHelper

  def nav_label_tag(label_name, scope=nil, icon_class=nil)
    translated_label = I18n.t([scope, label_name].compact.join('.'))
    unless icon_class.nil?
      "<i class=\"#{icon_class}\"></i> " + translated_label
    else
      translated_label
    end
  end
end
