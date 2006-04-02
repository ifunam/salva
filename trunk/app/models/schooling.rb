class Schooling < ActiveRecord::Base

#validates_presence_of , :institutioncareer_id, :credential_id, institutioncareer, credential, :startyear, :titleholder, :institutioncareer_id, :credential_id
#validates_numericality_of :institutioncareer_id, :credential_id
belongs_to :institutioncareer
belongs_to :credential

end

