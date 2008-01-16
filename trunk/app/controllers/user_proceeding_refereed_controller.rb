 class UserProceedingRefereedController < MultiSalvaController
  def initialize
    super
    @model = UserProceeding
    @views = [ :proceeding_refereed, :conference, :user_proceeding_refereed]
    @models = [ UserProceeding, [Proceeding,  Conference]]
    @create_msg = 'La información se ha guardado'
    @update_msg = 'La información ha sido actualizada'
    @purge_msg = 'La información se ha borrado'
    @per_pages = 10
    @order_by = 'id'
    @list = { :joins => "INNER JOIN proceedings ON user_proceedings.proceeding_id  = proceedings.id AND  proceedings.isrefereed = 't'"}
  end
end
