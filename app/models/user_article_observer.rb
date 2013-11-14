class UserArticleObserver < ActiveRecord::Observer
  def after_create(user_article)
    ArticleNotifier.author_notification(user_article.id).deliver
  end
end
