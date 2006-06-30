class Group < ActiveRecord::Base
  acts_as_tree 
  
  validates_presence_of :name
  validates_uniqueness_of :group_id, :scope => [:name, :parent_id]
  validates_numericality_of :parent_id
  
  belongs_to :group, :class_name => 'Group', :foreign_key => 'parent_id'
end
