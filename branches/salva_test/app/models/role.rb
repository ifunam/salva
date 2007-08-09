class Role < ActiveRecord::Base
  validates_numericality_of :id, :allow_nil => true, :only_integer => true
  validates_presence_of :name
  validates_inclusion_of :has_group_right, :in => [true, false]
  validates_uniqueness_of :name
end
