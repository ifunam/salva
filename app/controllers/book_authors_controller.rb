class BookAuthorsController < PublicationController
   defaults :resource_class => Bookedition,
            :collection_name => 'book_authors',
            :instance_name => 'book_author',
            :user_role_class => :bookedition_roleinbooks,
            :role_class => :roleinbook,
            :resource_class_scope => :authors

  def create
    if params['book_author']['book_attributes']['is_selected'].to_s=='1' and User.find(current_user.id).my_selected_books.count>5 then
      redirect_to new_book_author_path(params), :notice => "No está permitido tener más de 5 libros selectos"
      return(current_user.id.to_s)
    end
    set_user_in_role_class!
    build_resource.registered_by_id = current_user.id
    create! { collection_url }
  end

  def update
    if params['book_author']['book_attributes']['is_selected'].to_s=='1' and User.find(current_user.id).my_selected_books.count>5 then
      redirect_to edit_book_author_path(params), :notice => "No está permitido tener más de 5 libros selectos"
      return(current_user.id.to_s)
    end
    set_user_in_role_class!
    resource.modified_by_id = current_user.id
    update! { collection_url }
  end

end
