
 # require 'rubygems'  # if installed via gems
require 'xml/libxml'
require 'xml/libxslt'

# Create a new XSL Transform
xslt = XML::XSLT.file('/home/alex/projects/rails/salva/templates/resume.xsl')
xslt.doc = XML::Document.file('resume.xml')

# Parse to create a stylesheet, then apply.
s = xslt.parse
s.apply

# To save the result to a file:
File.open('resume.html', 'w') do |f|
  s.save(f)
end

# To output the result to stdout
s.print
