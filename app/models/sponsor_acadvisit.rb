class SponsorAcadvisit < ActiveRecord::Base
  validates_presence_of :acadvisit_id, :institution_id, :amount
  validates_numericality_of :id, :allow_nil => true, :greater_than => 0, :only_integer => true
  validates_numericality_of :acadvisit_id, :institution_id, :amount,  :greater_than => 0, :only_integer => true

  belongs_to :acadvisit
  belongs_to :institution

  validates_associated :acadvisit
  validates_associated :institution
end
