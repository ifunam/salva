class KnowledgeArea < ActiveRecord::Base
  # attr_accessor :name, :name_en, :knowledge_field_id, :short_name

  validates_presence_of :name, :knowledge_field_id
  validates_numericality_of :id, :allow_nil => true, :greater_than => 0, :only_integer => true
  validates_uniqueness_of :name

  has_many :user_knowledge_areas
  belongs_to :knowledge_field

  default_scope -> { order(knowledge_field_id,:id) }

  def to_s
    name
  end

  def my_labs
    users = []
    lab_ids = []
    lab_names = []
    ukas = UserKnowledgeArea.where(:knowledge_area_id=>id).uniq
    ukas.each{ |uka| users << uka.user_id }
    ulgs = UserLabOrGroup.where('user_id in (?)',users).uniq
    ulgs.each{ |ulg| lab_ids << ulg.lab_or_group_id }
    labs = LabOrGroup.where('id in (?)',lab_ids).uniq
    labs.each{ |lab| lab_names << lab.name+'|'+lab.url.to_s }
    lab_names
  end
end
