class InstitutionalActivity < ActiveRecord::Base
  validates_presence_of :descr, :institution_id, :startyear
  validates_numericality_of :id, :allow_nil => true, :greater_than => 0, :only_integer => true
  validates_numericality_of :institution_id, :user_id, :startyear, :greater_than => 0, :only_integer => true

  belongs_to :institution
  belongs_to :user
  belongs_to :registered_by, :class_name => 'User'
  belongs_to :modified_by, :class_name => 'User'

  def as_text
    [descr, institution.name, start_date, end_date].compact.join(', ')
  end

  def start_date
    if !startyear.to_s.strip.empty? and !startmonth.to_s.strip.empty?
      'Año y mes de inicio: ' + [startmonth, startyear].join('/')
    elsif !startyear.to_s.strip.empty?
      "Año de inicio: #{startyear}"
    end
  end

  def end_date
    if !endyear.to_s.strip.empty? and !endmonth.to_s.strip.empty?
      'Año y mes de término: ' + [endmonth, endyear].join('/')
    elsif !endyear.to_s.strip.empty?
      "Año de término: #{endyear}"
    end
  end
end
