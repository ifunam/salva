class UserCourseController < MultiSalvaController
  def initialize
    super
    @model = UserCourse
    @views = [:course, :user_course]
    @models = [ UserCourse, Course]
    @create_msg = 'La información se ha guardado'
    @update_msg = 'La información ha sido actualizada'
    @purge_msg = 'La información se ha borrado'
    @per_pages = 10
    @order_by = 'id'
    @list = { :include => [:roleincourse], :conditions => "roleincourses.name = 'Asistente' AND roleincourses.id =user_courses.roleincourse_id"}
  end
end
