class StudentAdviceController < MultiSalvaController
  def initialize
    super
    @model = Indivadvice
    @views = [:student_advice, :institution]
    @models = [ Indivadvice, Institution ]
    @create_msg = 'La información se ha guardado'
    @update_msg = 'La información ha sido actualizada'
    @purge_msg = 'La información se ha borrado'
    @per_pages = 10
    @order_by = 'id'
    @list = { :conditions => "indivadvicetarget_id < 4" }
  end
end
