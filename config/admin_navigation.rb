require Rails.root.to_s + '/app/helpers/navigation_helper'
SimpleNavigation::Configuration.run do |navigation|
  navigation.extend NavigationHelper
  navigation.items do |primary|
    primary.item :system_admin, nav_label_tag(:system_admin, 'admin'), administrator_admin_dashboard_path
  end
end
