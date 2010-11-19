class NewspaperArticlesController < PublicationController
  defaults :resource_class => Newspaperarticle, :collection_name => 'newspaper_articles', :instance_name => 'newspaper_article',
           :user_role_class => :user_newspaperarticles
end