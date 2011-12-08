class ProceedingCollaborationsController < PublicationController
   defaults :resource_class => Proceeding,
            :collection_name => 'proceedings',
            :instance_name => 'proceeding',
            :user_role_class => :user_proceedings,
            :role_class => :roleproceeding
end