class UserTechreportsController < MultiSalvaController
  def initialize
    super
    @model = UserGenericwork
    @views = [:techreport, :user_techreport]
    @models = [ UserGenericwork, Genericwork ]
    @create_msg = 'La información se ha guardado'
    @update_msg = 'La información ha sido actualizada'
    @purge_msg = 'La información se ha borrado'
    @per_pages = 10
    genericworktype_id = Genericworktype.find_by_name('Reportes técnicos').id
    @list = {:conditions => "genericworks.genericworktype_id = #{genericworktype_id} AND genericworks.id = user_genericworks.genericwork_id", :include => [:genericwork], :order => "genericworks.year DESC, genericworks.month DESC, genericworks.title ASC"}
  end
end
