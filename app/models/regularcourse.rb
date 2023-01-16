# encoding: utf-8
class Regularcourse < ActiveRecord::Base
  # attr_accessor :title, :modality_id, :user_regularcourses_attributes, :semester, :credits, :academicprogram_attributes
  validates_presence_of :title, :modality_id
  validates_numericality_of :id, :academicprogram_id, :allow_nil => true, :greater_than => 0, :only_integer => true
  validates_numericality_of :semester, :credits, :allow_nil => true, :only_integer => true
  validates_numericality_of :modality_id,  :greater_than => 0, :only_integer => true

  belongs_to :academicprogram
  accepts_nested_attributes_for :academicprogram
  belongs_to :modality
  belongs_to :registered_by, :class_name => 'User', :foreign_key => 'registered_by_id'
  belongs_to :modified_by, :class_name => 'User', :foreign_key => 'modified_by_id'

  has_many :user_regularcourses
  has_many :users, :through => :user_regularcourses
  has_many :periods, :through => :user_regularcourses
  accepts_nested_attributes_for :user_regularcourses
  user_association_methods_for :user_regularcourses

  has_paper_trail

  default_scope -> { includes(:user_regularcourses => :period).order(periods: { enddate: :desc }, regularcourses: { title: :asc }) }
  scope :user_id_eq, lambda { |user_id| joins(:user_regularcourses=>:period).where(:user_regularcourses => { :user_id => user_id }) }
  scope :user_id_not_eq, lambda { |user_id| where("regularcourses.id IN (#{UserRegularcourse.unscoped.regularcourse_id_not_eq_user_id(user_id).to_sql}) AND regularcourses.id  NOT IN (#{UserRegularcourse.unscoped.regularcourse_id_by_user_id(user_id).to_sql})") }
  scope :period_id_eq, lambda { |period_id| joins({:user_regularcourses => :period}, :regularcourses).where(:user_regularcourses => { :period_id => period_id }) }
  scope :since, lambda { |date| joins(:user_regularcourses=>:period).where("user_regularcourses.period_id IN (#{Period.select('id').where({:startdate.gteq => date}).to_sql})") }
  scope :until, lambda { |date| joins(:user_regularcourses=> :period).where("user_regularcourses.period_id IN (#{Period.select('id').where({:enddate.lteq => date}).to_sql})") }
  scope :among, lambda{ |start_date, end_date|  since(start_date).until(end_date) }

  # search_methods :user_id_eq, :user_id_not_eq, :period_id_eq
  # search_methods :among, :type => [:date, :date], :splat_param => true

  def to_s
    [to_s_simple, period_list].compact.join(', ')
  end

  def to_s_simple
      sem = semester == 0 ? nil : "Semestre: #{semester}"
      cred = credits.nil? ? nil : "Créditos: #{credits}"
      [title, "Modalidad: #{modality.name}", sem, cred, academicprogram.to_s_with_career].compact.join(', ')
  end

  def short_description
    [title, academicprogram.to_s_with_career].join(', ')
  end

  def period_list
    if periods.size > 0
      'Periodos: ' + user_regularcourses.collect { |record| record.period.title }.join(', ')
    end
  end
end
