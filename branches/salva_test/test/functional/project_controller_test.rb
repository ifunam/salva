require 'salva_controller_test'
require 'project_controller'

class Project_Controller_Test < SalvaControllerTest
  fixtures :projecttypes,:projectstatuses,:projects

  def initialize(*args) #This is an ugly  hack, but  it works
    super
    @mycontroller = ProjectController.new
    @myfixtures =  {
    :name => 'salva', :projecttype_id => 3, :projectstatus_id =>1, :descr => 'sistema curricular', :responsible => 'Alex J', :startyear => 2007,
    :id=> 3}
     @class = Project

    @mybadfixtures = {
   :name => nil, :projecttype_id => 3, :projectstatus_id =>1, :descr => 'sistema curricular', :responsible => nil, :startyear => nil
     }

     @children = {
      'projectinstitution' => %w( project_id institution_id ),
      'projectfinancingsource' => %w( project_id institution_id amount),
      'projectresearchline' => %w(project_id researchline_id),
      'projectresearcharea' => %w(project_id researcharea_id),
      'projectbook' => %w(project_id book_id),
      'projectchapterinbook' => %w(project_id chapterinbook_id),
      'projectconferencetalk' => %w(project_id conferencetalk_id),
      'projectacadvisit' => %w(project_id acadvisit_id),
      'projectgenericwork' => %w(project_id genericwork_id),
      'projectarticle' => %w( project_id article_id ),
    }

  end
end
