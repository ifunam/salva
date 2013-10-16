# encoding: utf-8
class Thesis < ActiveRecord::Base
  attr_accessible :title, :authors, :user_theses_attributes, :thesismodality_id, :thesisstatus_id, :end_date, :career_attributes, :start_date,
    # TODO: Remove this attributes for next release
    :startyear, :startmonth, :endyear, :endmonth

  validates_presence_of :thesisstatus_id, :thesismodality_id, :authors, :title, :end_date
  validates_numericality_of :id,:institutioncareer_id, :allow_nil => true, :greater_than => 0, :only_integer => true
  validates_numericality_of :thesisstatus_id, :thesismodality_id, :greater_than => 0, :only_integer => true

  belongs_to :career
  accepts_nested_attributes_for :career

  belongs_to :thesisstatus
  belongs_to :thesismodality
  belongs_to :institutioncareer # FIX IT: Remove this relationship until next release.
  # We need institutioncareers table to support
  # migrations from previous versions of salva databases.

  belongs_to :registered_by, :class_name => 'User', :foreign_key => 'registered_by_id'
  belongs_to :modified_by, :class_name => 'User', :foreign_key => 'modified_by_id'

  has_many :user_theses
  has_many :thesis_jurors
  has_many :users, :through => :user_theses
  accepts_nested_attributes_for :user_theses
  user_association_methods_for :user_theses

  has_paper_trail

  default_scope :order => 'theses.end_date DESC, theses.start_date DESC, theses.authors ASC, theses.title ASC'
  scope :user_id_eq, lambda { |user_id| joins(:user_theses).where(:user_theses => { :user_id => user_id }) }

  scope :user_id_not_eq, lambda { |user_id|
    theses_without_user_sql = UserThesis.user_id_not_eq(user_id).to_sql
    theses_with_user_sql = UserThesis.user_id_eq(user_id).to_sql
    sql = "theses.id IN (#{theses_without_user_sql}) AND theses.id NOT IN (#{theses_without_user_sql})"
    where sql
  }

  scope :roleinthesis_id_eq, lambda { |roleinthesis_id|  where(:user_theses => {:roleinthesis_id =>roleinthesis_id }) }
  scope :roleinthesis_id_not_eq, lambda { |roleinthesis_id| joins(:user_theses).where("user_thesis.roleinthesis_id != ?", roleinthesis_id) }
  scope :as_author, roleinthesis_id_eq(1)
  scope :not_as_author, roleinthesis_id_not_eq(1)

  scope :finished, where(:thesisstatus_id => 3).not_as_author
  scope :inprogress, where("thesisstatus_id != 3").not_as_author

  scope :for_phd, joins(:career).where('degree_id = 6').not_as_author
  scope :for_master, joins(:career).where('degree_id = 5 or degree_id = 4').not_as_author
  scope :for_bachelor_degree, joins(:career).where('degree_id = 3').not_as_author
  scope :for_technician, joins(:career).where('degree_id = 2').not_as_author
  scope :for_high_school, joins(:career).where('degree_id = 1').not_as_author
  
  scope :career_degree_id_eq, lambda { |degree_id| joins(:career).where{{:careers => {:degree_id => degree_id}}}.not_as_author }


  search_methods :user_id_eq, :user_id_not_eq, :roleinthesis_id_eq, :career_degree_id_eq

  def to_s
    ["#{authors} (estudiante)", title, thesismodality.to_s, career.to_s, date, users_and_roles].compact.join(', ')
  end

  def users_and_roles
    user_theses.collect {|record| record.to_s }.join(', ')
  end

  def date
    date = (end_date.is_a?Date) ? end_date : Date.today
    d = I18n.localize(date)
    thesisstatus_id == 3 ? "Fecha de presentación de examen: #{d}" : "Fecha estimada de presentación y obtención de grado: #{d}"
  end
end
