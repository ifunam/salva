class UserArticlesController < ModelMapperController
   def initialize 
     #@model_mapper = ModelDependentMapper.new([ UserArticle,[ Article, [ Journal, Publisher ] ] ])
     @model_mapper = ModelDependentMapper.new([ UserArticle,[ Article ] ])
     @views_sequence = [  [:published_articles, :articles], :user_articles ]
   end
end