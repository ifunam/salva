class Conferencetalk < ActiveRecord::Base
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

  scope :user_id_eq, lambda { |user_id|
    joins(:user_conferencetalks).
    where(:user_conferencetalks => { :user_id => user_id })
  }

  scope :user_id_not_eq, lambda { |user_id|
      where("conferencetalks.id IN (#{UserConferencetalk.select('DISTINCT(conferencetalk_id) as conferencetalk_id').
      where(["user_conferencetalks.user_id != ?", user_id]).to_sql}) AND conferencetalks.id  NOT IN (#{UserConferencetalk.select('DISTINCT(conferencetalk_id) as conferencetalk_id').
      where(["user_conferencetalks.user_id = ?", user_id]).to_sql})")
  }

  scope :year_eq, lambda { |year| joins(:conference).where('conferences.year = ?', year) }

  default_scope joins(:conference).order("conferences.year DESC, conferencetalks.authors ASC, conferencetalks.title ASC")

  search_methods :user_id_eq, :user_id_not_eq, :year_eq

  def as_text
    [ authors, "#{talktype.name}: #{title}", "Modalidad: #{modality.name}",
      conference.as_text
    ].join(', ')
  end
end
