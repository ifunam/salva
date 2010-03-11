class Views::Layouts::Page < Erector::RailsWidget
  # Array of javascript files
  @@js = []  
  def self.js(*files)
    files.each {|f| @@js << f unless @@js.include?(f) }
  end

  # Array of css files
  @@css = []
  def self.css(*files)
    files.each {|f| @@css << f unless @@css.include?(f) }
  end

  # Inline css code
  @@styles = []
  def self.style(txt)
    @@styles << txt
  end

  # Inline javascript code
  @@scripts = []
  def self.script(txt)
    @@scripts << txt
  end

  @@jqueries = []
  def self.jquery(txt)
    @@jqueries << txt
  end

  def doctype
    '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">'
  end

  # override me in a view
  def page_title
    "Page Title"
  end

  # override me in a layout
  def body_content
    text "No action rendered"
  end

  # override me
  def setup
    # No setup
  end

  def content
    setup
    rawtext doctype
    html :xmlns => 'http://www.w3.org/1999/xhtml', 'xml:lang' => 'en', :lang => 'en' do
      head { head_content }
      body do
        body_content
      end
    end
  end

  def head_content
    meta 'http-equiv' => 'content-type', :content => 'text/html;charset=UTF-8'
    title page_title
    @@js.each do |file|
      javascript_include_tag file
    end
    @@css.each do |file|
      stylesheet_link_tag file
    end
    inline_styles
    inline_scripts
  end

  def inline_styles
    style :type=>"text/css", 'xml:space' => 'preserve' do
      rawtext "\n"
      @@styles.each do |txt|
        rawtext "\n"
        rawtext txt
      end
    end
  end

  def inline_scripts
    javascript do
      @@scripts.each do |txt|
        rawtext "\n"
        rawtext txt
      end
      @@jqueries.each do |txt|
        rawtext "\n"
        rawtext "$(document).ready(function(){\n"
        rawtext txt
        rawtext "\n});"
      end
    end
  end
  def request
    @controller.request
  end

  def controller_name
    @@controller_name 
  end

  def action_name
    @@action_name 
  end

  def params
    @@params
  end

  def flash
    @@flash ||= {}
  end
end

