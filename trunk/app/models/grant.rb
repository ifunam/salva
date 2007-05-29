class Grant < ActiveRecord::Base
  validates_numericality_of :id, :allow_nil => true, :only_integer => true
  validates_numericality_of :institution_id, :allow_nil => true, :only_integer => true

  validates_presence_of :name, :institution_id
  validates_length_of :name, :within => 2..300

  validates_uniqueness_of :name, :scope => [:institution_id]

  belongs_to :institution

  validates_associated :institution, :on => :update
end
