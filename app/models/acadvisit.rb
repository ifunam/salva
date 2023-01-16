class Acadvisit < ActiveRecord::Base
  # attr_accessor :country_id, :institution_id, :descr, :acadvisittype_id, :startyear, :startmonth, :endyear,
  #  :endmonth, :place, :goals, :other

  validates_presence_of :institution_id, :country_id, :acadvisittype_id, :descr, :startyear
  validates_numericality_of :user_id, :institution_id, :country_id, :acadvisittype_id, :startyear, :greater_than => 0, :only_integer => true
  validates_numericality_of :endyear, :startmonth, :endmonth, :allow_nil => true, :greater_than => 0, :only_integer => true

  validates_inclusion_of :startmonth, :endmonth,  :in => 1..12, :allow_nil => true
  validates_uniqueness_of :id

  belongs_to :user
  belongs_to :institution
  belongs_to :country
  belongs_to :acadvisittype
  belongs_to :registered_by, :class_name => 'User'
  belongs_to :modified_by, :class_name => 'User'

  validates_associated :institution
  validates_associated :country
  validates_associated :acadvisittype

  has_many :projectacadvisits

  default_scope -> { order(endyear: :desc, endmonth: :desc, startyear: :desc, startmonth: :desc) }
  scope :adscription_id, lambda { |id|
    joins(:user => :user_adscription)
      .where(:user => {:user_adscription => {:adscription_id => id}})
  }

  # search_methods :adscription_id

  def to_s
    [institution.name_and_parent_abbrev, country.name, descr, start_date, end_date].compact.join(', ')
  end
end
