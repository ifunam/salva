class Group < ActiveRecord::Base
  acts_as_tree 
  validates_presence_of :name
  validates_uniqueness_of :parent_id, :scope => [:name, :parent_id]
  validates_numericality_of :parent_id, :allow_nil => true, :only_integer => true
  
  belongs_to :group, :class_name => 'Group', :foreign_key => 'parent_id'
end
