class Userconference < ActiveRecord::Base

  validates_presence_of  :roleinconference_id

  validates_numericality_of :id, :allow_nil => true, :greater_than => 0, :only_integer => true
  validates_numericality_of  :roleinconference_id, :user_id,  :greater_than =>0,  :only_integer => true


  belongs_to :conference
  belongs_to :roleinconference
  belongs_to :user

  default_scope :order => 'conferences.month ASC, conferences.name ASC', :include => [ :conference ]
  named_scope :as_attenders, :conditions => "roleinconference_id = 1" 
  named_scope :as_coordinator, :conditions => "roleinconference_id != 1"
  named_scope :find_by_conference_year, lambda { |y| { :conditions => [ 'conferences.year = ?', y ],  :include => [ :conference ] } }
  
  def as_text
      as_text_line([conference.name, conference.location, conference.country.name, month_to_s(conference.month),
                    conference.year, label_for(user.person.fullname, roleinconference.name)
                    ])
  end
end
