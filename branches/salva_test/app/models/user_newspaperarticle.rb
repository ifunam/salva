class UserNewspaperarticle < ActiveRecord::Base
  validates_presence_of :newspaperarticle_id

  validates_numericality_of :id, :allow_nil => true, :greater_than =>0, :only_integer => true
  validates_numericality_of :newspaperarticle_id, :user_id,  :greater_than =>0, :only_integer => true

  validates_inclusion_of :ismainauthor, :in=> [true, false]

  belongs_to :newspaperarticle

  validates_associated :newspaperarticle
end
