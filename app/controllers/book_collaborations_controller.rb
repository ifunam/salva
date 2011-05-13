class BookCollaborationsController < PublicationController
   defaults :resource_class => Bookedition,
            :collection_name => 'book_collaborations',
            :instance_name => 'book_collaboration',
            :user_role_class => :bookedition_roleinbooks,
            :role_class => :roleinbook,
            :resource_class_scope => :collaborators
end
