class UserNewspaperarticle < ActiveRecord::Base
  validates_numericality_of :id, :newspaperarticle_id, :user_id, :allow_nil => true, :greater_than =>0, :only_integer => true
  validates_inclusion_of :ismainauthor, :in=> [true, false]

  belongs_to :newspaperarticle
end
