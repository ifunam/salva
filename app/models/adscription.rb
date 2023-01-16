class Adscription < ActiveRecord::Base
  validates_presence_of :name, :institution_id
  validates_numericality_of :id, :allow_nil => true, :greater_than => 0, :only_integer => true
  validates_numericality_of :institution_id, :greater_than => 0, :only_integer => true
  validates_uniqueness_of :name, :scope => [:institution_id]
  normalize_attributes :name, :abbrev
  # attr_accessor :name, :abbrev, :descr, :administrative_key, :is_enabled, :institution_id

  belongs_to :institution
  has_many :user_adscription_records
  has_many :users, -> { distinct.where(userstatus_id: 2, user_adscription_records: { year: Time.now.year }).include(:person).order(people: { lastname1: :asc, firstname: :asc }, users: { author_name: :asc }) },
          :through => :user_adscription_records, :source => :user
  has_many :user_adscriptions

  default_scope -> { order(name: :asc) }

  scope :enabled, -> { where(:is_enabled => true) }
  scope :not_enabled, -> { where(:is_enabled => false) }

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
        users_with_this_jobposition(record.users.researchers.activated, name, [1, 110, 4, 5, 114])
      when 'postdoctorals' then
        users_with_this_jobposition(record.users.posdoctorals.activated, name, [111])
      when 'conacyt' then
        users_with_this_jobposition(record.users.conacyt.activated, name, [114])
      when 'academic_technicians' then
        users_with_this_jobposition(record.users.academic_technicians.activated, name, [3])
      else record.users.activated
     end
    end
  end

  private
  def self.users_with_this_jobposition(records, name, roleinjobpositions)
    records.collect { |record|
      if record.adscription_name(record.id,Time.now.year) == name
        record
      end
    }.compact
  end

end
