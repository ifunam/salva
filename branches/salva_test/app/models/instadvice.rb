class Instadvice < ActiveRecord::Base
  validates_presence_of :title, :institution_id, :instadvicetarget_id, :year
  validates_numericality_of :id, :allow_nil => true, :greater_than => 0, :only_integer => true
  validates_numericality_of :user_id, :institution_id, :instadvicetarget_id, :year,  :greater_than => 0, :only_integer => true
  validates_inclusion_of :month, :in => 1..12, :allow_nil => true

  belongs_to :institution
  belongs_to :instadvicetarget
  belongs_to :user

  validates_associated :institution
  validates_associated :instadvicetarget
  validates_associated :user
end
