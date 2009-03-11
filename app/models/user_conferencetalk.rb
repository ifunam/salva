class UserConferencetalk < ActiveRecord::Base

  validates_numericality_of :id, :allow_nil => true,:greater_than => 0, :only_integer => true
  validates_presence_of :roleinconferencetalk_id
  validates_numericality_of :user_id, :roleinconferencetalk_id, :greater_than =>0 , :only_integer => true

  belongs_to :conferencetalk
  belongs_to :roleinconferencetalk
  belongs_to :user

  validates_associated :conferencetalk
  validates_associated :roleinconferencetalk

  default_scope :order => 'conferencetalks.authors ASC, conferencetalks.title ASC, conferences.month DESC',
                :include => [ { :conferencetalk => :conference } ]
  named_scope :local_scope, :conditions => 'conferences.conferencescope_id = 1'
  named_scope :national_scope, :conditions => 'conferences.conferencescope_id = 2'
  named_scope :international_scope, :conditions => 'conferences.conferencescope_id = 3'
  named_scope :find_by_conference_year, lambda { |y| { :conditions => [ 'conferences.year = ?', y ] } }

  def as_text
    as_text_line([conferencetalk.authors, conferencetalk.title, conferencetalk.talktype.name, conferencetalk.conference.name,
                  conferencetalk.conference.location, conferencetalk.conference.country.name, month_to_s(conferencetalk.conference.month),
                  conferencetalk.conference.year, conferencetalk.talkacceptance.name, roleinconferencetalk.name
                  ])
  end

  def as_text_with_role
    as_text_line([conferencetalk.authors, conferencetalk.title, conferencetalk.talktype.name, conferencetalk.conference.name,
                  conferencetalk.conference.location, conferencetalk.conference.country.name, month_to_s(conferencetalk.conference.month),
                  conferencetalk.conference.year, conferencetalk.talkacceptance.name, label_for(user.person.fullname, roleinconferencetalk.name)
                  ])
  end

end
