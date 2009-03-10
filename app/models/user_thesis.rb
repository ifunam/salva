class UserThesis < ActiveRecord::Base
  validates_presence_of  :roleinthesis_id
  validates_numericality_of :id, :user_id, :thesis_id, :allow_nil => true, :greater_than => 0, :only_integer => true
  validates_numericality_of :roleinthesis_id, :greater_than => 0, :only_integer => true

  belongs_to :user
  belongs_to :thesis
  belongs_to :roleinthesis
  
  named_scope :published, :conditions => 'theses.thesisstatus_id = 3', :include => :thesis
  named_scope :unpublished, :conditions => 'theses.thesisstatus_id != 3', :include => :thesis
  named_scope :bachelor, :conditions => 'careers.degree_id = 3', :include => [{ :thesis => { :institutioncareer =>  :career } }]
  named_scope :master, :conditions => 'careers.degree_id = 5', :include => [{ :thesis => { :institutioncareer =>  :career } }]
  named_scope :phd, :conditions => 'careers.degree_id = 6', :include => [{ :thesis => { :institutioncareer =>  :career } }]

  named_scope :find_by_thesis_year, lambda { |y| { :conditions => ['theses.startyear = ? OR theses.endyear = ?', y, y], 
                                                   :order => 'people.lastname1 ASC, people.lastname2 ASC, people.firstname ASC, theses.endmonth ASC, theses.title ASC',
                                                   :include => [ { :user => :person}, :thesis ]
                                                   }
                                            }
  def as_text
    as_text_line([user.person.fullname + " (#{roleinthesis.name.downcase})", "thesis.title",
                  label_for(thesis.institutioncareer.career.name, thesis.institutioncareer.career.degree.name),
                  thesis.institutioncareer.institution.name, month_to_s(thesis.endmonth),
                  thesis.endyear, thesis.authors + " (estudiante)"
                  ])
  end
  
  def as_text_with_status
    as_text_line([user.person.fullname + " (#{roleinthesis.name.downcase})", thesis.title,
                  label_for(thesis.institutioncareer.career.name, thesis.institutioncareer.career.degree.name),
                  thesis.institutioncareer.institution.name, label_for(thesis.startyear, 'Año de inicio'), label_for(thesis.endyear, 'Año de término'), 
                  thesis.authors + " (estudiante)", label_for(thesis.thesisstatus.name, 'Estado')
                  ])
  end
  
end

