class BookChaptersController < PublicationController
   defaults :resource_class => Chapterinbook,
            :collection_name => 'book_chapters',
            :instance_name => 'book_chapter',
            :user_role_class => :chapterinbook_roleinchapters,
            :role_class => :roleinchapter
end
