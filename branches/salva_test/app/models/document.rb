class Document < ActiveRecord::Base
  validates_presence_of :documenttype_id, :title, :startdate, :enddate

  validates_numericality_of :id, :allow_nil => true, :greater_than => 0, :only_integer => true
  validates_numericality_of :documenttype_id, :greater_than => 0, :only_integer => true

  validates_uniqueness_of  :title, :scope => [:documenttype_id]

  belongs_to :documenttype
  validates_associated :documenttype

  has_many :user_documents
  has_many :users, :through => :user_documents

  def validate
      errors.add(:startdate, "La fecha de inicio no debe ser posterior")  || enddate < startdate
  end
end
