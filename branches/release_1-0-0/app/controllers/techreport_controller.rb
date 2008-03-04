class TechreportController < SalvaController
  def initialize
    super
    @model = Genericwork
    @create_msg = 'La información se ha guardado'
    @update_msg = 'La información ha sido actualizada'
    @purge_msg = 'La información se ha borrado'
    @per_pages = 10
    genericworktype_id = Genericworktype.find_by_name('Reportes técnicos').id
    @list = { :conditions => "genericworktype_id = #{genericworktype_id}" }
  end
end
