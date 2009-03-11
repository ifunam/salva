class Adscription < ActiveRecord::Base
  validates_presence_of :name, :institution_id
  validates_numericality_of :id, :allow_nil => true, :greater_than => 0, :only_integer => true
  validates_numericality_of :institution_id, :greater_than => 0, :only_integer => true
  validates_uniqueness_of :name, :scope => [:institution_id]

  belongs_to :institution

  has_many :user_adscriptions
  has_many :users, :through => :user_adscriptions, :source => :user
  

  has_many :activated_users, :through => :user_adscriptions, :source => :user, :conditions => 'users.userstatus_id = 2', :uniq => true


  def self.find_by_name_and_category(name, category)
    case category
      when 'researcher'
        conditions = "(jobpositions.jobpositioncategory_id <= 12 OR jobpositions.jobpositioncategory_id = 37)"
      when 'posdoc'
        conditions = "jobpositions.jobpositioncategory_id = 38"
      when 'academic_technician'
        conditions = "(jobpositions.jobpositioncategory_id BETWEEN 25 AND 36)"
    end
    find_by_name(name).user_adscriptions.find(:all, :conditions => conditions, :include => :jobposition).collect { |record|
       record.user 
    }
  end

  validates_associated :institution
end
