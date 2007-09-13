class SponsorAcadvisit < ActiveRecord::Base
  validates_numericality_of :id, :allow_nil => true, :only_integer => true
  validates_numericality_of :acadvisit_id, :allow_nil => true, :only_integer => true
  validates_numericality_of :institution_id, :allow_nil => true, :only_integer => true
  validates_numericality_of :amount
  validates_presence_of :acadvisit_id, :institution_id, :amount
  belongs_to :acadvisit
  belongs_to :institution
end
