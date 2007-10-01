class UserNewspaperarticle < ActiveRecord::Base
  validates_presence_of :newspaperarticle_id, :user_id
  validates_numericality_of :id, :allow_nil => true, :only_integer => true
  validates_numericality_of :newspaperarticle_id, :allow_nil => true, :only_integer => true
  validates_numericality_of :user_id, :allow_nil => true, :only_integer => true

  validates_inclusion_of :ismainauthor, :in=> [true, false]
  validates_uniqueness_of :user_id, :scope => [:newspaperarticle_id]

  belongs_to :newspaperarticle
  belongs_to :user

end
