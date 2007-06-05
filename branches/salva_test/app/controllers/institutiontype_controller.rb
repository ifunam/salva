class InstitutiontypeController < SalvaController
  def initialize
    super
    @model = Institutiontype
    @create_msg = 'El tipo de instituciÃ³n ha sido agregado'
    @update_msg = 'El tipo de instituciÃ³n ha sido actualizado'
    @purge_msg = 'El tipo de instituciÃ³n se ha borrado'
    @per_pages = 10
    @order_by = 'name'
  end
end
