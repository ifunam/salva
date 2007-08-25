class Membership < ActiveRecord::Base
  validates_presence_of :institution_id, :user_id
  validates_numericality_of :id, :allow_nil => true, :only_integer => true
  validates_numericality_of :institution_id, :allow_nil => true, :only_integer => true
  validates_numericality_of :user_id, :allow_nil => true, :only_integer => true

  belongs_to :institution
  belongs_to :user
end
