class Genericworktype < ActiveRecord::Base
  validates_numericality_of :id, :allow_nil => true, :only_integer => true
  validates_numericality_of :genericworkgroup_id, :only_integer => true
  validates_presence_of :name, :genericworkgroup_id
  validates_uniqueness_of :name, :scope => [:genericworkgroup_id]
  validates_associated :genericworkgroup, :on => :update
  belongs_to :genericworkgroup
end
