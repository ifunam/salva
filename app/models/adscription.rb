class Adscription < ActiveRecord::Base
  validates_presence_of :name, :institution_id
  validates_numericality_of :id, :allow_nil => true, :greater_than => 0, :only_integer => true
  validates_numericality_of :institution_id, :greater_than => 0, :only_integer => true
  validates_uniqueness_of :name, :scope => [:institution_id]

  belongs_to :institution

  has_many :user_adscriptions
  has_many :users, :through => :user_adscriptions, :source => :user, :uniq => true 

  def self.find_users_by_name_and_category(name, category)
     record = find_by_name(name)
     case category
        when 'researchers' then record.users.researchers.activated
        when 'posdocs' then record.users.posdocs.activated
        when 'academic_technicians' then record.users.academic_technicians.activated
        else record.users.activated
     end
   end
end
