class Role < ActiveRecord::Base

  validates_presence_of :name, :has_group_right
  validates_inclusion_of :has_group_right, :in=> %w(f t)
  validates_uniqueness_of :name
  
end
