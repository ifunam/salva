require 'salva'
module ThemeHelper
  def layout_from_theme
    theme = get_conf('theme')
    path = "#{RAILS_ROOT}/themes/#{theme}/layouts/"
    layout = path + @controller.class.name.sub(/Controller$/, '').underscore + '.rhtml'
    layout = path+'application.rhtml' unless FileTest.exist?(layout)
    render :file => layout,  :use_full_path => false
  end
end

