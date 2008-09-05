class Tree < ActiveRecord::Base
  

acts_as_tree
  validates_presence_of :name
  attr_accessor :style

  def self.roots
    self.find(:all, :conditions=>["parent_id = ?", 0])
  end

  def level
    self.ancestors.size
  end

  acts_as_nested_set
end
