class Userconference < ActiveRecord::Base
  attr_accessible :user_id, :roleinconference_id, :conference_id

  validates_presence_of  :roleinconference_id

  validates_numericality_of :id, :allow_nil => true, :greater_than => 0, :only_integer => true
  validates_numericality_of  :roleinconference_id, :user_id,  :greater_than =>0,  :only_integer => true

  #validates_uniqueness_of :user_id, :scope => [:conference_id, :roleinconference_id], :message => 'El rol del usuario esta duplicado'

  belongs_to :conference
  belongs_to :roleinconference
  belongs_to :user

  def author_with_role
    [user.author_name, "(#{roleinconference.name})"].join(" ")
  end
end
