class TutorialCommitteeController < MultiSalvaController
  def initialize
    super
    @model = TutorialCommittee
    @views = [ :tutorial_committee, :professional_career, :institution]
    @models = [ TutorialCommittee, [Institutioncareer, Career, Institution]]
    @create_msg = 'La información se ha guardado'
    @update_msg = 'La información ha sido actualizada'
    @purge_msg = 'La información se ha borrado'
    @per_pages = 10
    @order_by = 'id'
  end
end
