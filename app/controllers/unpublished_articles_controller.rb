class UnpublishedArticlesController < PublicationController
  defaults :user_role_class => :user_articles, :resource_class => Article, :collection_name => 'articles', 
           :instance_name => 'article', :resource_class_scope => :unpublished
end
