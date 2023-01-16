class UserConferencetalk < ActiveRecord::Base
  # attr_accessor :roleinconferencetalk_id, :conferencetalk_id, :user_id

  validates_numericality_of :id, :allow_nil => true,:greater_than => 0, :only_integer => true
  validates_presence_of :roleinconferencetalk_id
  validates_numericality_of :user_id, :roleinconferencetalk_id, :greater_than =>0 , :only_integer => true

  belongs_to :conferencetalk
  belongs_to :roleinconferencetalk
  belongs_to :user
  belongs_to :registered_by, :class_name => 'User'
  belongs_to :modified_by, :class_name => 'User'

  scope :year_eq, lambda { |year| joins(:conferencetalk => :conference).where('conferences.year = ?', year) }

  scope :local, -> { joins(:conferencetalk => :conference).where('conferences.conferencescope_id = 1') }
  scope :national, -> { joins(:conferencetalk => :conference).where('conferences.conferencescope_id = 2') }
  scope :international, -> { joins(:conferencetalk => :conference).where('conferences.conferencescope_id = 3') }

  scope :conferencescope_id, lambda { |id| joins(:conferencetalk => :conference).where('conferences.conferencescope_id = ?', id) }
  scope :adscription_id, lambda { |id| joins(:user => :user_adscription).where(:user => { :user_adscription => { :adscription_id => id} }) }

  # search_methods :year_eq, :conferencescope_id, :adscription_id

  def author_with_role
    "#{user.author_name} (#{roleinconferencetalk.name})"
  end
end
