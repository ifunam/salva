class UserUnpublishedArticlesController < SalvaController
  def initialize
    super
    @model = Article
    @create_msg = 'La información se ha guardado'
    @update_msg = 'La información ha sido actualizada'
    @purge_msg = 'La información se ha borrado'
    @per_pages = 10
    articlestatus_id = Articlestatus.find_by_name('Publicado').id
    @list =  { :select => 'user_articles.*,  articles.*', :conditions => " articles.articlestatus_id != #{articlestatus_id} AND user_articles.article_id = articles.id", :include => [:article], :order => 'articles.year DESC, articles.month DESC, articles.title ASC' }
  end
  
  def list
    @model = UserArticle
    @primary_key = 'article_id'
    super
  end
  
  def create
    super
    @user_record = UserArticle.new({:article_id => @edit.id, :user_id => session[:user], :ismainauthor => true })
    @user_record.moduser_id =  session[:user]
    @user_record.save if @user_record.valid?
  end
  
  def purge
    UserArticle.find(:first, :conditions => {:article_id => params[:id], :user_id => session[:user]}).destroy
    super
  end
  
  def purge_selected
    if  params[:item]
      params[:item].each { |id, contents|
        UserArticle.find(:first, :conditions => {:article_id => id, :user_id => session[:user]}).destroy
      }
    end
    super
  end
end
