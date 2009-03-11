class UserAdscription < ActiveRecord::Base
  validates_presence_of :jobposition_id, :adscription_id, :startyear

  validates_numericality_of :id, :allow_nil => true, :greater_than =>0, :only_integer => true
  validates_numericality_of :jobposition_id, :adscription_id, :user_id, :greater_than =>0, :only_integer =>true

  validates_inclusion_of :startmonth, :endmonth,  :in => 1..12, :allow_nil => true

  belongs_to :jobposition
  belongs_to :adscription
  belongs_to :user


  validates_associated :jobposition
  validates_associated :adscription
end
