class CourseAttendeesController < PublicationController
  defaults :resource_class => Course, :collection_name => 'courses', :instance_name => 'course',
           :resource_class_scope => :attendees,
           :user_role_class => :user_courses, :role_class => :roleincourse
end
