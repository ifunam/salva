class BachelorSchoolingController < SalvaController
  def initialize
    super
    @model = Schooling
    @create_msg = 'La información se ha guardado'
    @update_msg = 'La información ha sido actualizada'
    @purge_msg = 'La información se ha borrado'
    @per_pages = 10
    @list = { :conditions => " schoolings.institutioncareer_id IN ( SELECT institutioncareers.id FROM institutioncareers, careers WHERE careers.degree_id =  3 AND institutioncareers.career_id = careers.id)" }
    @order_by = 'schoolings.endyear, schoolings.startyear DESC'
  end
end
