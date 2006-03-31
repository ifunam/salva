class MembershipController < SalvaController
  def initialize
    super
    @model = Membership
    @create_msg = 'La membresía ha sido agregada'
    @update_msg = 'La membresía ha sido actualizada'
    @purge_msg = 'La membresía se ha borrado'
    @per_pages = 10
    @order_by = 'descr, endyear, startyear'
  end
end
