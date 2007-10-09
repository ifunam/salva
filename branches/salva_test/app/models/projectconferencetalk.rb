class Projectconferencetalk < ActiveRecord::Base
  validates_presence_of :project_id, :conferencetalk_id

  validates_numericality_of :id, :allow_nil => true, :greater_than =>0, :only_integer => true
  validates_numericality_of :project_id, :conferencetalk_id, :greater_than =>0, :only_integer => true

   validates_uniqueness_of :project_id, :scope => [:conferencetalk_id]

  belongs_to :project
  belongs_to :conferencetalk

  validates_associated  :project
  validates_associated  :conferencetalk
end
