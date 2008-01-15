class BookeditionRoleinbookController < MultiSalvaController
  def initialize
    super
    @model = BookeditionRoleinbook
    @views = [ :book, :bookedition, :bookedition_roleinbook]
    @models = [ BookeditionRoleinbook, [ Bookedition, Book ] ]
    @create_msg = 'La edición  ha sido agregada'
    @update_msg = 'La edición ha sido actualizada'
    @purge_msg = 'La edición ha sido borrado'
    @per_pages = 10
    @order_by = 'id'
    @list = { :conditions=> "roleinbook_id < 3" }
  end
end
