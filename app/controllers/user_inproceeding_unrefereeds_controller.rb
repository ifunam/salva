class UserInproceedingUnrefereedsController < MultiSalvaController
  def initialize
    super
    @model = UserInproceeding
    @views = [ :inproceeding_unrefereed, :proceeding_unrefereed, :conference, :user_inproceeding_unrefereed]
    @models = [ UserInproceeding, [Inproceeding, [Proceeding, Conference]]]
    @create_msg = 'La información se ha guardado'
    @update_msg = 'La información ha sido actualizada'
    @purge_msg = 'La información se ha borrado'
    @per_pages = 10
    @order_by = 'id'
    @list = {:joins => "INNER JOIN proceedings ON proceedings.isrefereed = 'f' INNER JOIN inproceedings ON inproceedings.proceeding_id = proceedings.id AND inproceedings.id = user_inproceedings.inproceeding_id"}
  end
end
