class Thesis < ActiveRecord::Base
  validates_presence_of :thesisstatus_id, :thesismodality_id, :startyear, :authors, :title
  validates_numericality_of :id,:institutioncareer_id, :allow_nil => true, :greater_than => 0, :only_integer => true
  validates_numericality_of :thesisstatus_id, :thesismodality_id, :startyear,  :greater_than => 0, :only_integer => true

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
  has_many :users, :through => :user_theses
  accepts_nested_attributes_for :user_theses
  user_association_methods_for :user_theses

  default_scope :order => 'theses.endyear DESC, theses.startyear DESC, theses.title ASC'
  scope :user_id_eq, lambda { |user_id| joins(:user_theses).where(:user_theses => { :user_id => user_id }) }
  scope :user_id_not_eq, lambda { |user_id|  where("theses.id IN (#{UserThesis.select('DISTINCT(thesis_id) as thesis_id').where(["user_theses.user_id !=  ?", user_id]).to_sql}) AND theses.id  NOT IN (#{UserThesis.select('DISTINCT(thesis_id) as thesis_id').where(["user_theses.user_id =  ?", user_id]).to_sql})") }
  search_methods :user_id_eq, :user_id_not_eq

  
  def as_text
    [users_and_roles, title, career.as_text, date, "#{authors} (estudiante)"].compact.join(', ')
  end

  def users_and_roles
    user_theses.collect {|record| record.as_text }.join(', ')
  end

  def date
    thesisstatus_id == 3 ? end_date : [start_date, end_date].join(', ')
  end
end
