class RegularCoursesController < PublicationController
  defaults :resource_class => Regularcourse, :collection_name => 'regular_courses', :instance_name => 'regular_course',
           :user_role_class => :user_regularcourses, :role_class => :roleinregularcourse
end
