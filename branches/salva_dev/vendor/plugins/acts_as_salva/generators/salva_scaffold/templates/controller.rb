class <%= controller_class_name %>Controller < SalvaController
  def initialize
    super
    @model = <%= class_name %>
    @create_msg = 'El <%= class_name %> ha sido agregado'
    @update_msg = 'El <%= class_name %> ha sido actualizado'
    @purge_msg = 'El <%= class_name %> se ha ido a chingar a su madre'
    @per_pages = 10
    @order_by = ''
  end
end
