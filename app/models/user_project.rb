class UserProject < ActiveRecord::Base
  validates_presence_of :roleinproject_id
  validates_numericality_of :id,  :project_id, :allow_nil => true, :greater_than => 0, :only_integer => true
  validates_numericality_of :user_id, :roleinproject_id,  :greater_than => 0, :only_integer => true
  validates_uniqueness_of :user_id, :scope => [:roleinproject_id, :project_id]

  belongs_to :user
  belongs_to :project
  belongs_to :roleinproject
  
  default_scope  :include => [:project]
  named_scope :find_by_project_year, lambda { |y| { :conditions => ['projects.startyear = ? OR projects.endyear = ?', y, y] } }
  
  def as_text
     as_text_line([project.name, label_for(user.person.fullname, roleinproject.name), label_for(project.other, 'Fuente de financiamiento'),  
                  label_for(project.projecttype.name, 'Tipo de proyecto'), label_for(project.startyear, 'Año de inicio'), 
                  label_for(project.endyear, 'Año de término'),  label_for(project.projectstatus.name, 'Estado')
                  ])
  end
end
