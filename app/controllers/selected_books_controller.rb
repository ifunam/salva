class SelectedBooksController < PublicationController

  def index
    @user_books = BookeditionRoleinbook.authors.where(:user_id=>current_user.id)
    puts @user_books.count
    ub_ids = @user_books.map(&:bookedition_id)
    bookeditions = Bookedition.where('id in (?)', ub_ids)
    ub_ids = bookeditions.map(&:book_id)
    @books = Book.where('id in (?)', ub_ids)
    if params[:commit]
      b_ids = if params[:bs].nil? then nil else params[:bs] end
      if b_ids.nil? then
        Book.where('id in (?)', ub_ids).update_all(:is_selected=>false)
        redirect_to selected_books_path, :notice => "Libros selectos guardados exitosamente"
      elsif b_ids.count>5 then
        redirect_to selected_books_path, :notice => "No está permitido tener más de 5 libros selectos"
        return(current_user.id.to_s)
      else
        Book.where(id: b_ids).update_all(:is_selected=>true)
        Book.where('id in (?) and id not in(?)', ub_ids, b_ids).update_all(:is_selected=>false)
        redirect_to selected_books_path, :notice => "Libros selectos guardados exitosamente"
      end
    end
    @books
  end

end
