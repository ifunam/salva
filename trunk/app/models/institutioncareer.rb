class Institutioncareer < ActiveRecord::Base
  validates_presence_of :institution_id, :career_id
  validates_numericality_of :institution_id, :career_id
  belongs_to :institution
  belongs_to :career

  def as_text
    [career.as_text, institution.as_text].compact.join(', ')
  end
end
