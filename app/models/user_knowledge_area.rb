class UserKnowledgeArea < ActiveRecord::Base
  # attr_accessor :user_id, :knowledge_area_id
  validates_numericality_of :id, :allow_nil => true, :greater_than => 0, :only_integer => true
  validates_numericality_of :knowledge_area_id, :user_id, :greater_than => 0, :only_integer => true, :allow_nil => false
  validates_uniqueness_of :user_id, :scope => [:knowledge_area_id]

  belongs_to :user
  belongs_to :knowledge_area
  belongs_to :registered_by, :class_name => 'User'
  belongs_to :modified_by, :class_name => 'User'

  scope :knowledge_area_id_eq, lambda { |knowledge_area_id| select('*').where :knowledge_area_id => knowledge_area_id }

  # search_methods :user_id, :lab_or_group_id_eq

  def to_s
    knowledge_area.to_s
  end

  def self.grouped_users(knowledge_area_id=nil,user_type='research')
    users = case user_type
      when 'technician' then User.select(:id).academic_technicians
      when 'posdoc' then User.select(:id).posdoctorals
      else User.select(:id).researchers
    end
    users = users.map(&:id)
    ukas = knowledge_area_id_eq(knowledge_area_id).where('user_id in (?)',users)
    ukas.map(&:user_id)
  end
end
