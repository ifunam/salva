class ArticlestatusesController < SuperScaffoldController

   def initialize 
     @model = Articlestatus
     super
     @find_options = { :order => 'name ASC' }
   end
end