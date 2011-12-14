SimpleNavigation::Configuration.run do |navigation|
  navigation.items do |primary|
    primary.item :annual_reports, 'Informes anuales', web_site_annual_reports_path
    primary.item :annual_plans, 'Planes de trabajo', web_site_annual_plans_path
  end
end
