# encoding: utf-8
class Group < ActiveRecord::Base
  validates_presence_of :name
  validates_uniqueness_of :parent_id, :scope => [:name, :parent_id]
  validates_numericality_of :parent_id, :allow_nil => true, :only_integer => true

  # attr_accessor :name, :descr
  default_scope -> { order(descr: :asc) }
  belongs_to :group, :class_name => 'Group', :foreign_key => 'parent_id'

  has_many :user_groups
  has_many :users, :through => :user_groups
  has_many :roleingroups
end
