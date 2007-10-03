class Projectbook < ActiveRecord::Base
  validates_presence_of :project_id, :book_id
  validates_numericality_of :id, :allow_nil => true, :greater_than => 0, :only_integer => true
  validates_numericality_of :project_id, :allow_nil => true, :greater_than => 0, :only_integer => true
  validates_numericality_of :book_id, :allow_nil => true, :greater_than => 0, :only_integer => true

  validates_uniqueness_of :project_id, :scope => [:book_id]

  belongs_to :project
  belongs_to :book
end
