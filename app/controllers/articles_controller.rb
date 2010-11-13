class ArticlesController < PublicationController
  defaults :user_role_class => :user_articles, :resource_class_scope => :published
end
