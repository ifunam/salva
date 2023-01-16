class UserSeminary < ActiveRecord::Base
  # attr_accessor :roleinseminary_id, :user_id, :seminary_id
  validates_numericality_of :id, :allow_nil => true, :greater_than =>0, :only_integer => true
  validates_numericality_of :user_id, :roleinseminary_id,  :greater_than =>0,:only_integer => true
  validates_presence_of :roleinseminary_id
  validates_uniqueness_of :user_id, :scope => [:seminary_id, :roleinseminary_id]

  belongs_to :seminary
  belongs_to :roleinseminary
  belongs_to :user

  validates_associated :seminary
  validates_associated :roleinseminary

  scope :user_id_not_eq, lambda { |user_id| select('DISTINCT(seminary_id) as seminary_id').where(["user_seminaries.user_id !=  ?", user_id]) }
  scope :user_id_eq, lambda { |user_id| select('DISTINCT(seminary_id) as seminary_id').where :user_id => user_id }
  scope :year_eq, lambda { |year| joins(:seminary).where('seminaries.year = ?', year) }
  scope :adscription_id, lambda { |id| joins(:user => :user_adscription).where(:user => { :user_adscription => { :adscription_id => id} }) }

  # search_methods :year_eq, :adscription_id

  def author_with_role
    [user.author_name, "(#{roleinseminary.name})"].join(' ')
  end
end
