class Projectchapterinbook < ActiveRecord::Base
  validates_presence_of :project_id, :chapterinbook_id

  validates_numericality_of :id, :allow_nil => true, :only_integer => true
  validates_numericality_of :project_id, :allow_nil => true, :only_integer => true
  validates_numericality_of :chapterinbook_id, :allow_nil => true, :only_integer => true

  validates_uniqueness_of :project_id, :scope => [:chapterinbook_id]

  belongs_to :project
  belongs_to :chapterinbook
end
