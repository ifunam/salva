class Chapterinbook < ActiveRecord::Base
  validates_presence_of :bookedition_id, :bookchaptertype_id, :title
  validates_numericality_of :id, :allow_nil => true, :only_integer => true
  validates_numericality_of :bookedition_id, :allow_nil => true, :only_integer => true
  validates_numericality_of :bookchaptertype_id, :allow_nil => true, :only_integer => true

  validates_uniqueness_of :title, :scope => [:bookedition_id, :bookchaptertype_id]

  belongs_to :bookedition
  belongs_to :bookchaptertype

  has_many :projectchapterinbooks
end
