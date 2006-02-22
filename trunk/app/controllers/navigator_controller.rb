class NavigatorController < ApplicationController
   
   def get_tree
      if @session[:navtree] then
	 @session[:navtree]
      else
	 tree = [ 'Datos personale', [ 'address' ], 'Publicaciones', [ 'book', 'article', 'chapterinbook' ]]
        navtree = Tree.new(tree)
        navtree.data = 'Home'
        @session[:navtree] = navtree
        navtree
      end
   end
   
   def index
     navtab
   end
   
   def navbar
 #     @tree = get_tree
   end

   def navtab
     item = @params[:item] if @params[:item]
     tree = get_tree
     if item !=nil and tree.children[item.to_i] then
       @session[:navtree] = tree.children[item.to_i]
     end
     @tree = item!=nil ? tree.children[item.to_i]: tree  
     render :action => 'navtab'
   end
   
end
