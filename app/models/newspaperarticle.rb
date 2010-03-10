class Newspaperarticle < ActiveRecord::Base
  validates_presence_of :title, :authors, :newspaper_id, :newsdate

  validates_numericality_of :id, :allow_nil => true, :greater_than =>0, :only_integer => true
  validates_numericality_of :newspaper_id, :greater_than =>0, :only_integer => true

  #validates_uniqueness_of :title, :scope => [:newspaper_id, :newsdate]

  belongs_to :newspaper

end
