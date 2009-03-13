class UserJournal < ActiveRecord::Base
  validates_presence_of :journal_id, :roleinjournal_id, :startyear

  validates_numericality_of :id, :allow_nil => true, :greater_than => 0, :only_integer => true
  validates_numericality_of :user_id, :journal_id, :roleinjournal_id, :startyear, :greater_than => 0, :only_integer => true
  validates_numericality_of :startmonth, :endyear, :endmonth, :allow_nil => true, :greater_than => 0, :only_integer => true

  belongs_to :user
  belongs_to :journal
  belongs_to :roleinjournal

  validates_associated :journal
  validates_associated :roleinjournal
  default_scope :order => 'journals.name ASC, people.lastname1, people.lastname2, people.firstname', :include => [ :journal, { :user => :person } ]
  named_scope :find_by_year, lambda { |y| { :conditions => ['user_journals.startyear = ? OR user_journals.endyear = ?', y, y] } }
  
  def as_text
    as_text_line([journal.name, label_for(user.person.fullname, roleinjournal.name), label_for(startyear, 'Año de inicio'),
                  label_for(endyear, 'Año de término')])
  end
  
end
