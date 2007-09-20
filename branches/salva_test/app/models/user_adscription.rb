class UserAdscription < ActiveRecord::Base
  validates_numericality_of :id, :allow_nil => true, :only_integer => true
  validates_numericality_of :jobposition_id, :allow_nil => true, :only_integer => true
  validates_numericality_of :adscription_id, :allow_nil => true, :only_integer => true
  validates_numericality_of :user_id, :allow_nil => true, :only_integer => true
  validates_numericality_of :startyear, :only_integer => true
  validates_numericality_of :endyear, :only_integer => true
  validates_numericality_of :startmonth, :only_integer => true
  validates_numericality_of :endmonth, :only_integer => true
  validates_inclusion_of :startmonth, :in => 1..12
  validates_inclusion_of :endmonth, :in => 1..12
  validates_presence_of :jobposition_id, :adscription_id, :startyear, :user_id

  belongs_to :jobposition
  belongs_to :adscription
end
