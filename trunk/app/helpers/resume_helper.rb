require 'reporter'
module ResumeHelper
  def resume_as_html
    @r = Reporter.new('resume')
    @r.as_html
  end
end
