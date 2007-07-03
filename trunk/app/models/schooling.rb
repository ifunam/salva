class Schooling < ActiveRecord::Base
  validates_presence_of :institutioncareer_id, :startyear
  validates_numericality_of :institutioncareer_id, :startyear
  validates_numericality_of :endyear, :credits, :allow_nil => true
  belongs_to :institutioncareer

  def as_text
    years = startyear.to_s
    years += ' - ' + endyear.to_s unless endyear.nil?
    [institutioncareer.as_text, years].join(', ')
  end
end
