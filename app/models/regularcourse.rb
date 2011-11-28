# encoding: utf-8
class Regularcourse < ActiveRecord::Base
  validates_presence_of :title, :modality_id
  validates_numericality_of :id, :semester, :credits, :academicprogram_id, :allow_nil => true, :greater_than => 0, :only_integer => true
  validates_numericality_of :modality_id,  :greater_than => 0, :only_integer => true

  belongs_to :academicprogram
  accepts_nested_attributes_for :academicprogram
  belongs_to :modality
  belongs_to :registered_by, :class_name => 'User', :foreign_key => 'registered_by_id'
  belongs_to :modified_by, :class_name => 'User', :foreign_key => 'modified_by_id'

  has_many :user_regularcourses
  has_many :users, :through => :user_regularcourses
  accepts_nested_attributes_for :user_regularcourses
  user_association_methods_for :user_regularcourses

  default_scope :order => 'periods.startdate DESC, regularcourses.title', :include => { :user_regularcourses => :period }
  scope :user_id_eq, lambda { |user_id| joins(:user_regularcourses).where(:user_regularcourses => { :user_id => user_id }) }
  scope :user_id_not_eq, lambda { |user_id|  where("regularcourses.id IN (#{UserRegularcourse.select('DISTINCT(regularcourse_id) as regularcourse_id').where(["user_regularcourses.user_id !=  ?", user_id]).to_sql}) AND regularcourses.id  NOT IN (#{UserRegularcourse.select('DISTINCT(regularcourse_id) as regularcourse_id').where(["user_regularcourses.user_id =  ?", user_id]).to_sql})") }
  scope :period_id_eq, lambda { |period_id| joins(:user_regularcourses).where(:user_regularcourses => { :period_id => period_id }) }
  search_methods :user_id_eq, :user_id_not_eq, :period_id_eq

  def as_text
    sem = semester == 0 ? nil : "Semestre: #{semester}"
    cred = credits.nil? ? nil : "Créditos: #{credits}"
    [title, "Modalidad: #{modality.name}", sem, cred, academicprogram.as_text_with_career].compact.join(', ')
  end

  def short_description
    [title, academicprogram.as_text_with_career].join(', ')
  end
end
