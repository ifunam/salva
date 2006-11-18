class JobpositionAtInstitutionController < SalvaController
  def initialize
    super
    @model = Jobposition
    @create_msg = 'La información se ha guardado'
    @update_msg = 'La información ha sido actualizada'
    @purge_msg = 'La información se ha borrado'
    @per_pages = 10
    @list_include = :institution
    @list_conditions = "(institutions.institution_id = 1 OR institutions.id = 1) AND jobpositions.institution_id = institutions.id "
  end
end
