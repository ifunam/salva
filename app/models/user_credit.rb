# encoding: utf-8
class UserCredit < ActiveRecord::Base
  attr_accessible :credittype_id, :descr, :year, :month, :other

  validates_presence_of :credittype_id, :descr, :year
  validates_numericality_of :credittype_id

  belongs_to :credittype
  belongs_to :registered_by, :class_name => 'User'
  belongs_to :modified_by, :class_name => 'User'

  default_scope order('year DESC')
  scope :credits_on_phd_thesis, where(:credittype_id => 1)
  scope :credits_on_master_thesis, where(:credittype_id => 2)
  scope :credits_on_degree_thesis, where(:credittype_id => 3)
  scope :credits_on_international_article, where(:credittype_id => 4)
  scope :credits_on_national_article, where(:credittype_id => 5)
  scope :credits_on_others, where('credittype_id > 5')

  def as_text
    [descr, 'Créditos en: ' +credittype.name, date].join(', ')
  end
end
