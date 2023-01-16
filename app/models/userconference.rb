class Userconference < ActiveRecord::Base
  # attr_accessor :user_id, :roleinconference_id, :conference_id

  validates_presence_of  :roleinconference_id

  validates_numericality_of :id, :allow_nil => true, :greater_than => 0, :only_integer => true
  validates_numericality_of  :roleinconference_id, :user_id,  :greater_than =>0,  :only_integer => true

  #validates_uniqueness_of :user_id, :scope => [:conference_id, :roleinconference_id], :message => 'El rol del usuario esta duplicado'

  belongs_to :conference
  belongs_to :roleinconference
  belongs_to :user

  #default_scope :joins => :conference, :order => 'conferences.year DESC, conferences.month DESC, conferences.name ASC'
  scope :organizer, -> { where('userconferences.roleinconference_id > 1') }
  scope :year_eq, lambda { |year| joins(:conference).where('conferences.year = ?', year) }
  scope :conferencescope_id, lambda { |id| joins(:conference).where('conferences.conferencescope_id = ?', id) }
  scope :adscription_id, lambda { |id| joins(:user => :user_adscription).where(:user => { :user_adscription => { :adscription_id => id} }) }

  # search_methods :year_eq, :conferencescope_id, :adscription_id

  def author_with_role
    [user.author_name, "(#{roleinconference.name})"].join(" ")
  end
end
