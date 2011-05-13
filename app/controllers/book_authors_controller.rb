class BookAuthorsController < PublicationController
   defaults :resource_class => Bookedition,
            :collection_name => 'book_authors',
            :instance_name => 'book_author',
            :user_role_class => :bookedition_roleinbooks,
            :role_class => :roleinbook,
            :resource_class_scope => :authors
end
