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

  # TODO IT: Include this methods into ActiveRecord::Base from a module using metaprogramming
  def start_date
    'Fecha de inicio: ' + localize_date(startyear, startmonth).to_s  if !startyear.nil? or !startmonth.nil?
  end

  def end_date
    'Fecha de conclusión: ' + localize_date(endyear, endmonth).to_s if !endyear.nil? or !endmonth.nil?
  end

  def localize_date(year, month, format=:month_and_year)
    if !year.nil? and !month.nil?
      I18n.localize(Date.new(year, month, 1), :format => format).downcase
    elsif !year.nil?
      year
    end
  end
end
