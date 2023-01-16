class Seminary < ActiveRecord::Base
  # attr_accessor :title, :seminarytype_id, :user_seminaries_attributes, :year, :month, :institution_id, :instructors

  validates_presence_of  :title, :year, :seminarytype_id, :institution_id
  validates_numericality_of :seminarytype_id, :year,  :greater_than =>0, :only_integer => true
  validates_numericality_of :id, :month, :allow_nil => true, :greater_than =>0, :only_integer => true

  belongs_to :institution
  belongs_to :seminarytype
  belongs_to :registered_by, :class_name => 'User'
  belongs_to :modified_by, :class_name => 'User'

  has_many :user_seminaries
  has_many :users, :through => :user_seminaries
  accepts_nested_attributes_for :user_seminaries
  user_association_methods_for :user_seminaries

  has_paper_trail

  default_scope -> { order(year: :desc, month: :desc, instructors: :asc, title: :asc) }

  scope :as_not_attendee, -> { joins(:user_seminaries).where('user_seminaries.roleinseminary_id != 1') }
  scope :as_attendee, -> { joins(:user_seminaries).where('user_seminaries.roleinseminary_id != 1') }
  scope :user_id_eq, lambda { |user_id| joins(:user_seminaries).where(:user_seminaries => {:user_id => user_id}) }
  scope :user_id_not_eq, lambda { |user_id| 
    seminary_without_user_sql = UserSeminary.user_id_not_eq(user_id).to_sql
    seminary_with_user_sql = UserSeminary.user_id_eq(user_id).to_sql
    sql = "seminaries.id IN (#{seminary_without_user_sql}) AND seminaries.id NOT IN (#{seminary_with_user_sql})"
    where sql
  }
  # search_methods :user_id_eq, :user_id_not_eq

  def to_s
    [instructors, title, 'Tipo: ' + seminarytype.name, organizers, date].compact.join(', ')
  end

  def organizers
    organizers = user_seminaries.where(:roleinseminary_id => 3)
    'Organizador(es): ' + organizers.collect {|record| record.user.author_name }.join(', ') if organizers.size > 0
  end

  def seminarytype_name
    seminarytype_id.nil? ? '-' : seminarytype.name
  end

  def institution_name
    institution_id.nil? ? '-' : institution.name
  end

  def institution_country
    institution_id.nil? ? '-' : institution.country_name
  end
end
