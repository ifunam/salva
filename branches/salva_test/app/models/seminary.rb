class Seminary < ActiveRecord::Base
  validates_presence_of :title, :year, :institution_id, :isseminary, :message => "debes llenar los datos con asterisco correctamente"

validates_numericality_of :institution_id, :year,  :greater_than =>0, :only_integer => true
 validates_numericality_of :id, :month,  :allow_nil => true, :greater_than =>0, :only_integer => true



 validates_uniqueness_of :title, :scope => [:year, :institution_id]

 belongs_to :institution

 validates_associated :institution

end
