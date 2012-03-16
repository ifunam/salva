class Adscription < ActiveRecord::Base
  validates_presence_of :name, :institution_id
  validates_numericality_of :id, :allow_nil => true, :greater_than => 0, :only_integer => true
  validates_numericality_of :institution_id, :greater_than => 0, :only_integer => true
  validates_uniqueness_of :name, :scope => [:institution_id]
  normalize_attributes :name, :abbrev

  belongs_to :institution
  has_many :user_adscriptions
  has_many :users, :through => :user_adscriptions, :source => :user, :uniq => true,
           :conditions => 'users.userstatus_id = 2', :include => :person,
           :order => 'people.lastname1 ASC, people.firstname ASC, users.author_name ASC'

  default_scope :order => 'name ASC'

  scope :enabled, where(:is_enabled => true)
  scope :not_enabled, where(:is_enabled => false)

  def users_to_xml
    users.collect {|record|
      {:fullname => record.fullname_or_login, :id => record.id, :login => record.login, :email => record.email }
    }.to_xml(:root => :users)
  end

  def self.find_users_by_name_and_category(name, category)
    if self.exists?(:name => name)
     record = find_by_name(name)
     case category
      when 'researchers' then
        users_with_this_jobposition(record.users.researchers.activated, [1, 110, 4, 5])
      when 'postdoctorals' then
        users_with_this_jobposition(record.users.posdoctorals.activated, [111])
      when 'academic_technicians' then
        users_with_this_jobposition(record.users.academic_technicians.activated, [3])
      else record.users.activated
     end
    end
  end

  private
  def self.users_with_this_jobposition(records, roleinjobpositions)
    records.collect { |record|
      if roleinjobpositions.to_a.include? record.jobposition_for_researching.jobpositioncategory.roleinjobposition_id
        record
      end
    }.compact
  end
end
