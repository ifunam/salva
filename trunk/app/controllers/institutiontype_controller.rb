class InstitutiontypeController < SalvaController
  def initialize
    super
    @model = Institutiontype
    @create_msg = 'El tipo de institución ha sido agregado'
    @update_msg = 'El tipo de institución ha sido actualizado'
    @purge_msg = 'El tipo de institución se ha borrado'
    @per_pages = 10
    @order_by = 'name'
  end
end
