class Seminary < ActiveRecord::Base
  validates_presence_of  :title, :year, :seminarytype_id
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

  default_scope :order => 'year DESC, month DESC, instructors ASC, title ASC'

  scope :as_not_attendee, joins(:user_seminaries).where('user_seminaries.roleinseminary_id != 1')
  scope :as_attendee, joins(:user_seminaries).where('user_seminaries.roleinseminary_id != 1')
  scope :user_id_eq, lambda { |user_id| joins(:user_seminaries).where(:user_seminaries => {:user_id => user_id}) }
  scope :user_id_not_eq, lambda { |user_id|  where("seminaries.id IN (#{UserSeminary.select('DISTINCT(seminary_id) as seminary_id').where(["user_seminaries.user_id !=  ?", user_id]).to_sql}) AND seminaries.id  NOT IN (#{UserSeminary.select('DISTINCT(seminary_id) as seminary_id').where(["user_seminaries.user_id =  ?", user_id]).to_sql})") }
  search_methods :user_id_eq, :user_id_not_eq

  def as_text
    [instructors, title, 'Tipo: ' + seminarytype.name, organizers, date].compact.join(', ')
  end

  def organizers
    organizers = user_seminaries.where(:roleinseminary_id => 3)
    'Organizador(es): ' + organizers.collect {|record| record.user.author_name }.join(', ') if organizers.size > 0
  end
end
