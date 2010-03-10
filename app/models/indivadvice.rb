class Indivadvice < ActiveRecord::Base
  validates_presence_of :indivadvicetarget_id, :indivname, :startyear, :hours
  validates_numericality_of :indivadvicetarget_id
  belongs_to :user
  belongs_to :indivuser, :class_name => "User", :foreign_key => "indivuser_id"
  belongs_to :institution
  belongs_to :indivadvicetarget
  belongs_to :indivadviceprogram
  belongs_to :degree
end
