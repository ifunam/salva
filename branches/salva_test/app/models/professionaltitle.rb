class Professionaltitle < ActiveRecord::Base

  validates_presence_of :schooling_id, :titlemodality_id
<<<<<<< .mine

=======
  validates_numericality_of :id, :allow_nil => true, :greater_than => 0, :only_integer => true
  validates_numericality_of :schooling_id,  :titlemodality_id, :greater_than => 0, :only_integer => true
>>>>>>> .r1716
  validates_numericality_of :id, :allow_nil => true, :greater_than =>0, :only_integer => true
  validates_numericality_of :schooling_id, :greater_than =>0, :only_integer => true
  validates_numericality_of :titlemodality_id, :greater_than =>0, :only_integer => true

  validates_uniqueness_of :schooling_id, :scope => [:titlemodality_id]

  belongs_to :schooling
  belongs_to :titlemodality
<<<<<<< .mine

  validates_associated :schooling
  validates_associated :titlemodality


=======

  validates_associated :schooling
  validates_associated :titlemodality
>>>>>>> .r1716
end
