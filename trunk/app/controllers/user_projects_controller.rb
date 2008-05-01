class UserProjectsController < MultiSalvaController
  def initialize
    super
    @model = UserProject
    @views = [:project, :user_project]
    @models = [ UserProject, Project ]
    @create_msg = 'La información se ha guardado'
    @update_msg = 'La información ha sido actualizada'
    @purge_msg = 'La información se ha borrado'
    @per_pages = 10
    @list = { :conditions => '(roleinproject_id < 5 OR roleinproject_id = 8)' }
  end
end
