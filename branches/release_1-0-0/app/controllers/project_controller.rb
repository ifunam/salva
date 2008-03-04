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
      'projectfinancingsource' => %w(institution_id amount), 
      'projectresearchline' => %w(researchline_id),
      'projectresearcharea' => %w(researcharea_id),
      'projectbook' => %w(book_id),
      'projectchapterinbook' => %w(chapterinbook_id),
      'projectconferencetalk' => %w(conferencetalk_id),
      'projectacadvisit' => %w(acadvisit_id),
      'projectgenericwork' => %w(genericwork_id),
      'projectarticle' => %w( article_id ),
      'projectthesis' => %w( thesis_id ),
    }
  end
end
