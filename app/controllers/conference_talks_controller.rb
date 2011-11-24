class ConferenceTalksController < PublicationController
  defaults :resource_class => Conferencetalk, :collection_name => 'conference_talks', :instance_name => 'conference_talk',
           :user_role_class => :user_conferencetalks, :role_class => :roleinconferencetalk
end
