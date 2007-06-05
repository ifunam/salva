class UserNewspaperarticle < ActiveRecord::Base
validates_presence_of :newspaperarticle_id, :ismainauthor
validates_numericality_of :newspaperarticle_id
belongs_to :newspaperarticle
end
