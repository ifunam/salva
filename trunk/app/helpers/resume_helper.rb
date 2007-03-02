require 'resume'
require 'reporter'
module ResumeHelper
  def resume_as_html
    @r = Reporter.new(QUERIES)
    @r.xml
  end
end
