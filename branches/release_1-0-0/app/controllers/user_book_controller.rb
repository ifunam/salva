class UserBookController < MultiSalvaController
  def initialize
    super
    @model = BookeditionRoleinbook
    @views = [ :book, :bookedition, :user_book]
    @models = [ BookeditionRoleinbook, [ Bookedition, Book ] ]
    @create_msg = 'La edición  ha sido agregada'
    @update_msg = 'La edición ha sido actualizada'
    @purge_msg = 'La edición ha sido borrado'
    @per_pages = 10
    @order_by = 'id'
    @list = { :conditions=> "roleinbook_id > 2" }
  end
end
