# encoding: utf-8
class UserCredit < ActiveRecord::Base
  attr_accessible :credittype_id, :descr, :year, :month, :other

  validates_presence_of :credittype_id, :descr, :year
  validates_numericality_of :credittype_id

  belongs_to :credittype
  belongs_to :registered_by, :class_name => 'User'
  belongs_to :modified_by, :class_name => 'User'

  default_scope :order => 'year DESC, month DESC'
  def to_s
    [descr, 'Créditos en: ' +credittype.name, date].join(', ')
  end
end
