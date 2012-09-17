require Rails.root.to_s + '/app/helpers/navigation_helper'
SimpleNavigation::Configuration.run do |navigation|
  navigation.extend NavigationHelper
  navigation.items do |primary|
    primary.item :users, nav_label_tag(:users, 'admin'), admin_dashboard_path
    primary.item :catalogs, nav_label_tag(:catalogs, 'admin'), rails_admin_path
    primary.item :reports, nav_label_tag(:reports, 'admin'), admin_dashboard_path
  end
end
