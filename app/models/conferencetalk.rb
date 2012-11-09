class Conferencetalk < ActiveRecord::Base
  attr_accessible :authors, :title, :talktype_id, :talkacceptance_id, :modality_id,
                  :user_conferencetalks_attributes, :conference_attributes

  validates_presence_of :title, :authors, :talktype_id, :talkacceptance_id, :modality_id

  validates_numericality_of :id, :allow_nil => true, :greater_than =>0, :only_integer => true
  validates_numericality_of :talktype_id, :talkacceptance_id, :modality_id, :greater_than =>0 , :only_integer => true

  belongs_to :conference
  belongs_to :talktype
  belongs_to :talkacceptance
  belongs_to :modality
  belongs_to :registered_by, :class_name => 'User'
  belongs_to :modified_by, :class_name => 'User'
  accepts_nested_attributes_for :conference

  has_many :user_conferencetalks
  has_many :users, :through => :user_conferencetalks
  accepts_nested_attributes_for :user_conferencetalks
  user_association_methods_for :user_conferencetalks

  has_paper_trail

  scope :user_id_eq, lambda { |user_id|
    includes(:user_conferencetalks => {:conferencetalk => :conference}).
    where(:user_conferencetalks => { :user_id => user_id })
  }

  scope :user_id_not_eq, lambda { |user_id|
    talk_without_user_sql = UserConferencetalk.select('DISTINCT(conferencetalk_id) as conferencetalk_id').where(["user_conferencetalks.user_id != ?", user_id]).to_sql
    talk_with_user_sql = UserConferencetalk.select('DISTINCT(conferencetalk_id) as conferencetalk_id').where(["user_conferencetalks.user_id = ?", user_id]).to_sql
    sql = "conferencetalks.id IN (#{talk_without_user_sql}) AND conferencetalks.id NOT IN (#{talk_with_user_sql})"
    where(sql)
  }

  default_scope includes(:conference).order("conferences.year DESC, conferencetalks.authors ASC, conferencetalks.title ASC")
  scope :local_scope, :conditions => 'conferences.conferencescope_id = 1', :include => [:conference]
  scope :national_scope, :conditions => 'conferences.conferencescope_id = 2', :include => [:conference]
  scope :international_scope, :conditions => 'conferences.conferencescope_id = 3', :include => [:conference]
  scope :since, lambda { |year| includes(:conference).where(["conferences.year >= ?", year])}
  scope :until, lambda { |year| includes(:conference).where(["conferences.year <= ?", year])}
  scope :year_eq, lambda { |year| joins(:conference).where('conferences.year = ?', year) }
  scope :among, lambda { |start_year, end_year| includes(:conference).where(["conferences.year = ?", start_year])}
  search_methods :user_id_eq, :user_id_not_eq, :year_eq
  search_methods :among, :splat_param => true, :type => [:integer, :integer]

  def as_text
    [ authors, "#{talktype.name}: #{title}", "Modalidad: #{modality.name}",
      conference.as_text
    ].join(', ')
  end
end
