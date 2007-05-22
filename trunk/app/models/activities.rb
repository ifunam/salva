class Genericworktype < ActiveRecord::Base
  validates_numericality_of :id, :allow_nil => true, :only_integer => true
  validates_numericality_of :activity_id, :only_integer => true
  validates_length_of :name, :within => 10..500
  validates_presence_of :name, :activity_id
  validates_uniqueness_of :name, :scope => [:activity_id]
  validates_associated :activity, :on => :update
belongs_to :activitytype
end
