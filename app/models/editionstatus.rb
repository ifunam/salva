class Editionstatus < ActiveRecord::Base
  # attr_accessor :name
   validates_presence_of :name
   validates_numericality_of :id, :allow_nil => true, :greater_than => 0, :only_integer => true
   validates_uniqueness_of :name
   default_scope -> { order(name: :asc) }
end
