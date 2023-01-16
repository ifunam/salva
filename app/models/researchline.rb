class Researchline < ActiveRecord::Base
  # attr_accessor :name, :name_en, :descr, :researcharea_id

  validates_presence_of :name#, :researcharea_id
  validates_numericality_of :id, :allow_nil => true, :greater_than => 0, :only_integer => true
  validates_numericality_of :researcharea_id, :allow_nil => true, :greater_than => 0, :only_integer => true
  # validates_uniqueness_of :name, :scope => [:researcharea_id]

  belongs_to :researcharea
  has_many :user_researchlines

  belongs_to :registered_by, :class_name => 'User'
  belongs_to :modified_by, :class_name => 'User'

  default_scope -> { order(name: :asc) }

  def to_s
    name
  end

  def to_s_with_researcharea
    [name, researcharea_id.nil? ? nil : researcharea.name].compact.join(', ')
  end
 end
