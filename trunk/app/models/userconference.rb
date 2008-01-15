class Userconference < ActiveRecord::Base

  validates_presence_of  :roleinconference_id

  validates_numericality_of :id, :allow_nil => true, :greater_than => 0, :only_integer => true
  validates_numericality_of  :roleinconference_id, :user_id,  :greater_than =>0,  :only_integer => true



  #validates_uniqueness_of :user_id, :scope => [:conference_id, :roleinconference_id], :message => 'El rol del usuario esta duplicado'

  belongs_to :conference
  belongs_to :roleinconference
  belongs_to :user

  validates_associated :conference
  validates_associated :roleinconference
end
