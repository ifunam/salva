class Seminary < ActiveRecord::Base
  validates_presence_of  :title, :year, :seminarytype_id
  validates_numericality_of :seminarytype_id, :year,  :greater_than =>0, :only_integer => true
  validates_numericality_of :id, :month, :allow_nil => true, :greater_than =>0, :only_integer => true

  belongs_to :institution
  belongs_to :seminarytype
  belongs_to :registered_by, :class_name => 'User'
  belongs_to :modified_by, :class_name => 'User'
  has_many   :user_seminaries

  def as_text
    [instructors, title, 'Tipo: ' + seminarytype.name, organizers, date].compact.join(', ')
  end

  def organizers
    organizers = user_seminaries.where(:roleinseminary_id => 3)
    'Organizador(es): ' + organizers.collect {|record| record.user.author_name }.join(', ') if organizers.size > 0
  end

  def date(format=:month_and_year)
    if !year.nil? and !month.nil?
      I18n.localize(Date.new(year, month, 1), :format => format).downcase
    elsif !year.nil?
      year
    end
  end
end
