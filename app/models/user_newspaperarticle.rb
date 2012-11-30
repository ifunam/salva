class UserNewspaperarticle < ActiveRecord::Base
  attr_accessible :newspaperarticle_id, :user_id, :ismainauthor

  validates_numericality_of :id, :newspaperarticle_id, :user_id, :allow_nil => true, :greater_than =>0, :only_integer => true
  validates_inclusion_of :ismainauthor, :in=> [true, false]
  belongs_to :user
  belongs_to :newspaperarticle
  attr_accessible :user_id

  scope :user_id_not_eq, lambda { |user_id| select('DISTINCT(newspaperarticle_id) as newspaperarticle_id').where(["user_newspaperarticles.user_id !=  ?", user_id]) }
  scope :user_id_eq, lambda { |user_id| select('DISTINCT(newspaperarticle_id) as newspaperarticle_id').where :user_id => user_id }

end
