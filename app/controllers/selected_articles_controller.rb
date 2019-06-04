class SelectedArticlesController < PublicationController

  def index
    @user_articles = UserArticle.where(:user_id => current_user.id)
    ua_ids = @user_articles.map(&:article_id)
    @articles = Article.where('id in (?)', ua_ids)
    if params[:commit]
      a_ids = if params[:as].nil? then nil else params[:as] end
      if a_ids.nil? then
        Article.where('id in (?)', ua_ids).update_all(:is_selected=>false)
        redirect_to selected_articles_path, :notice => "Artículos selectos guardados exitosamente"
      elsif a_ids.count>5 then
        redirect_to selected_articles_path, :notice => "No está permitido tener más de 5 artículos selectos"
        return(current_user.id.to_s)
      else
        Article.where(id: a_ids).update_all(:is_selected=>true)
        Article.where('id in (?) and id not in(?)', ua_ids, a_ids).update_all(:is_selected=>false)
        redirect_to selected_articles_path, :notice => "Artículos selectos guardados exitosamente"
      end
    end
    @articles
  end

end
