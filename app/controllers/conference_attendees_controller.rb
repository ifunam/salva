class ConferenceAttendeesController < PublicationController
  defaults :resource_class => Conference, :collection_name => 'conferences', :instance_name => 'conference',
           :resource_class_scope => :attendees,
           :user_role_class => :userconferences, :role_class => :roleinconference
end
