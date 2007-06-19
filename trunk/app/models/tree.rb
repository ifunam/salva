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

   def get_tree_from_parent(parent)
     tree = self
     start = 1
     (start..parent).to_a.reverse.each  do  tree = tree.parent  end
     tree
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
     children.collect { |node|  node.data if node.data }
   end

   def has_left_node?
     return true if left_node != nil
     return false
   end

   def left_node
     if self.has_parent?
       return self.parent.children[index_for_node - 1] if self.parent.children.size > 1  and index_for_node != 0
     end
   end

   def has_right_node?
     return true if right_node != nil
     return false
   end

   def right_node
     if self.has_parent?
       return self.parent.children[index_for_node + 1] if self.parent.children.last.data != self.data and self.parent.children.size > 1
     end
   end

   def index_for_node(data=self.data)
     if self.has_parent?
       self.parent.children_data.index(data)
     else
       self.children_data.index(data)
     end
   end
 end

