class UserNewspaperarticle < ActiveRecord::Base
  validates_presence_of :newspaperarticle_id
  validates_numericality_of :newspaperarticle_id
  validates_inclusion_of :ismainauthor, :in=> [true, false]
  belongs_to :newspaperarticle
end
