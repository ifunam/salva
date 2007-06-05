class SponsorAcadvisit < ActiveRecord::Base
validates_presence_of :acadvisit_id, :institution_id, :amount
validates_numericality_of :acadvisit_id, :institution_id
belongs_to :acadvisit
belongs_to :institution
end
