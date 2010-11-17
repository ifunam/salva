class UserSchoolarship < ActiveRecord::Base
  validates_presence_of :schoolarship_id, :start_date
  validates_numericality_of :schoolarship_id, :allow_nil => false,  :greater_than => 0, :only_integer => true
  validates_numericality_of :id, :allow_nil => true,  :greater_than => 0, :only_integer => true

  belongs_to :schoolarship
  belongs_to :registered_by, :class_name => 'User'
  belongs_to :modified_by, :class_name => 'User'
  
  def as_text
    [schoolarship.name_and_institution_abbrev, start_date, end_date].compact.join(', ')
  end
  
  def start_date
    if !startyear.to_s.strip.empty? and !startmonth.to_s.strip.empty?
      'Año y mes de inicio:' + [startmonth, startyear].join('/') 
    elsif !startyear.to_s.strip.empty?
      "Año de inicio: #{startyear}"
    end
  end
  
  def end_date
    if !endyear.to_s.strip.empty? and !endmonth.to_s.strip.empty?
      'Año y mes de término:' + [endmonth, endyear].join('/') 
    elsif !endyear.to_s.strip.empty?
      "Año de término: #{endyear}"
    end
  end
end
