require Rails.root.to_s + '/app/helpers/navigation_helper'
SimpleNavigation::Configuration.run do |navigation|
  navigation.extend NavigationHelper
  navigation.items do |primary|
    primary.item :system_admin, nav_label_tag(:system_admin, 'admin'), admin_dashboard_path
    primary.item :catalogs, nav_label_tag(:catalogs, 'admin'), rails_admin_path
    primary.item :resque, nav_label_tag(:resque, 'admin'), rails_admin_path if Rails.env.production?
  end
end
