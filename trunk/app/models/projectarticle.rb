class Projectarticle < ActiveRecord::Base
  validates_presence_of :project_id, :article_id
  validates_numericality_of :id, :allow_nil => true, :greater_than => 0, :only_integer => true
  validates_numericality_of :project_id, :article_id, :greater_than => 0, :only_integer => true
  validates_uniqueness_of :project_id, :scope => [:article_id]

  belongs_to :project
  belongs_to :article

  validates_associated :project
  validates_associated :article
end
