class Membership < ActiveRecord::Base
  validates_presence_of :institution_id
  validates_numericality_of :id, :allow_nil => true, :greater_than =>0, :only_integer => true
  validates_numericality_of  :user_id, :greater_than =>0 , :only_integer => true

  belongs_to :institution
  belongs_to :user


end
