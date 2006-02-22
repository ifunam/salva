
class Tree
   
   attr_accessor :data
   attr_accessor :parent
   attr_accessor :children
   
   def initialize(array = nil)
      @parent = nil
      @children = []
      @data = nil
      addChildren(array) if array
   end
   
   def has_parent?
      @parent != nil
   end
   
   def is_leaf?
      @children.empty?
   end
   
   def has_children? 
      !is_leaf?
   end
   
   def addChildren(array)
      if array.is_a? Array then
	 node_prev = nil
	 array.each { |item|
	    node = nil
	    if item.is_a? Array then
	       if node_prev then
		  node_prev.addChildren(item)
	       else 
		  node = Tree.new(item)
		  addChild(node)
	       end
	    else
	       node = Tree.new
	       node.data = item
	       addChild(node)
	    end	    
	    node_prev = node if node
	 }
      end
   end
   
   def addChild(node)
      @children << node
      node.parent = self if node.is_a? Tree
      print 'No es un nodo '+node if !(node.is_a? Tree)
   end
       
   def root
      node = self
      node = node.parent until not node.has_parent?
      node
   end
   
   def path
      p = [ ]
      node = self
      p <<  node.data if node.data
      while node.has_parent?
	 node = node.parent 
	 p <<  node.data if node.data
      end
      p
   end
   
   def children_data
      p = []
      children.each { |node|
	 p <<  node.data if node.data
      }
      p
   end
						
end
