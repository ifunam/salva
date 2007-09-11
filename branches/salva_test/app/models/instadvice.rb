class Instadvice < ActiveRecord::Base
  validates_presence_of :title, :user_id, :institution_id, :instadvicetarget_id, :year

  validates_numericality_of :id, :allow_nil => true, :only_integer => true
  validates_numericality_of :user_id, :allow_nil => true, :only_integer => true
  validates_numericality_of :institution_id, :allow_nil => true, :only_integer => true
  validates_numericality_of :instadvicetarget_id, :allow_nil => true, :only_integer => true
  validates_numericality_of :year, :only_integer => true

  # validates_uniqueness_of :title, :scope => [:user_id, :institution_id, :instadvicetarget_id, :year]

  belongs_to :user
  belongs_to :institution
  belongs_to :instadvicetarget
end
