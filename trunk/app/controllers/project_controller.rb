class ProjectController < SalvaController
  def initialize
    super
    @model = Project
    @create_msg = 'La información se ha guardado'
    @update_msg = 'La información ha sido actualizada'
    @purge_msg = 'La información se ha borrado'
    @per_pages = 10
    @order_by = 'id'
    @children = { 
      'projectinstitution' => %w( institution_id ),
      'projectfinancingsource' => %w( project_id institution_id amount), 
      'projectresearchline' => %w(project_id researchline_id),
      'projectresearcharea' => %w(project_id researcharea_id),
      'projectbook' => %w(project_id book_id),
      'projectchapterinbook' => %w(project_id chapterinbook_id),
      'projectconferencetalk' => %w(project_id conferencetalk_id),
      'projectacadvisit' => %w(project_id acadvisit_id),
      'projectgenericwork' => %w(project_id genericwork_id),
      'projectarticle' => %w( article_id ),
    }
  end
end
