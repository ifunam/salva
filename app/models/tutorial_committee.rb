class TutorialCommittee < ActiveRecord::Base
  # attr_accessor :studentname, :descr, :year, :career_attributes, 
  #                 :institution_id, :university_id, :country_id, :degree_id, :career_id
  validates_presence_of :studentname,  :year
  validates_numericality_of :id, :user_id, :allow_nil => true, :greater_than => 0, :only_integer => true

  belongs_to :career
  belongs_to :career, :class_name => 'Career', :foreign_key => 'career_id'
  belongs_to :degree, :class_name => 'Degree', :foreign_key => 'degree_id'
  belongs_to :institution, :class_name => 'Institution', :foreign_key => 'institution_id'
  belongs_to :university, :class_name => 'Institution', :foreign_key => 'university_id'
  belongs_to :country, :class_name => 'Country', :foreign_key => 'country_id'

  accepts_nested_attributes_for :career
  belongs_to :institutioncareer # FIX IT: Remove this relationship until next release.
                                # We need institutioncareers table to support
                                # migrations from previous versions of salva databases.

  belongs_to :user
  belongs_to :registered_by, :class_name => 'User', :foreign_key => 'registered_by_id'
  belongs_to :modified_by, :class_name => 'User', :foreign_key => 'modified_by_id'

  default_scope -> { order(tutorial_committees: { year: :desc, studentname: :asc }) }
  scope :degree_id, lambda { |id| where("degree_id = ?", id) }
  scope :adscription_id, lambda { |id| joins(:user => :user_adscription).where(:user => { :user_adscription => { :adscription_id => id} }) }

  # search_methods :degree_id, :adscription_id

  def to_s
    carrera =  career.nil? ? nil : career.name
    grado = degree.nil? ? nil : degree.name
    escuela = institution.nil? ? nil : institution.name
    universidad = university.nil? ? nil : university.name
    ["#{studentname} (estudiante), Carrera: #{carrera}, Grado: #{grado}, #{escuela}, #{universidad}", year].compact.join(', ')
  end
end
