class UserArticlesController < ModelMapperController
   def initialize
     @model_mapper = ModelDependentMapper.new([ UserArticle,[ Article, [ Journal, Publisher ] ] ])
     @views_sequence = [  [:published_articles, :articles], :user_articles ]
   end
end
