class UserProceeding < ActiveRecord::Base
  validates_presence_of :roleproceeding_id
  validates_numericality_of :id, :user_id, :proceeding_id, :allow_nil => true, :greater_than => 0, :only_integer => true
  validates_numericality_of :roleproceeding_id, :greater_than => 0, :only_integer => true


  belongs_to :user
  belongs_to :proceeding
  belongs_to :roleproceeding

   named_scope :find_by_year, :conditions => 'proceedings.year = 2008 OR conferences.year = 2008', 
              :order => 'proceedings.title ASC, conferences.name ASC, people.lastname1 ASC, people.lastname2, people.firstname',
              :include => [ { :proceeding => :conference }, { :user => :person }]

  def as_text
    publisher_name = proceeding.publisher.nil? ? nil : proceeding.publisher.name
    as_text_line([proceeding.title, 
                  label_for(proceeding.conference.name, proceeding.conference.conferencetype.name) + " (#{proceeding.conference.year})",
                  publisher_name, 
                  proceeding.conference.location, proceeding.conference.country.name, proceeding.volume,  
                  proceeding.year, label_for(user.person.fullname, roleproceeding.name)])
  end


end
