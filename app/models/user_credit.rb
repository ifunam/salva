class UserCredit < ActiveRecord::Base
  validates_presence_of :credittype_id, :descr, :year
  validates_numericality_of :credittype_id

  belongs_to :credittype
  belongs_to :registered_by, :class_name => 'User'
  belongs_to :modified_by, :class_name => 'User'
  def as_text
    [descr, 'Créditos en: ' +credittype.name, 'Año: ' + year.to_s].join(', ')
  end
end
