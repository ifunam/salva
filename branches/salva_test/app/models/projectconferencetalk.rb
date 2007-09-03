class Projectconferencetalk < ActiveRecord::Base
  validates_presence_of :project_id, :conferencetalk_id

  validates_numericality_of :id, :allow_nil => true, :only_integer => true
  validates_numericality_of :project_id, :allow_nil => true, :only_integer => true
  validates_numericality_of :conferencetalk_id, :allow_nil => true, :only_integer => true

  validates_uniqueness_of :project_id, :scope => [:conferencetalk_id]

  belongs_to :project
  belongs_to :conferencetalk
end
