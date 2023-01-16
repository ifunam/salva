class UserAdscription < ActiveRecord::Base
  # attr_accessor :user_id, :adscription_id, :descr, :jobposition_id

  validates_presence_of :adscription_id
  validates_numericality_of :id, :jobposition_id, :startyear, :user_id, :allow_nil => true, :greater_than =>0, :only_integer => true
  validates_numericality_of :adscription_id, :greater_than => 0, :only_integer => true
  validates_inclusion_of :startmonth, :endmonth,  :in => 1..12, :allow_nil => true

  belongs_to :jobposition
  belongs_to :adscription
  belongs_to :user

  has_many :user_adscription_records
  has_one :department_head

  after_create :update_user_id

  def update_user_id
    update_attributes(:user_id => jobposition.user_id) if self.user_id.nil?
  end

  def self.most_recent_adscription user_id
    query = "SELECT distinct(user_adscriptions.*) FROM user_adscriptions 
             WHERE user_adscriptions.user_id = ?",user_id
    if find_by_sql(query).size > 1 then
      @jp = Jobposition.most_recent_jp user_id
      query = "SELECT distinct(user_adscriptions.*) FROM user_adscriptions 
               WHERE user_adscriptions.user_id = ? AND user_adscriptions.jobposition_id = ?",user_id,@jp.id
    end
    find_by_sql(query).last
  end

  def self.all_adscriptions
    find_by_sql("SELECT name FROM adscriptions WHERE is_enabled=true ORDER BY name")
  end
  def self.research_adscriptions
    find_by_sql("SELECT name FROM adscriptions WHERE is_enabled=true AND name NOT LIKE '%Apoyo%' ORDER BY name")
  end
  def self.support_adscriptions
    find_by_sql("SELECT name FROM adscriptions WHERE is_enabled=true AND name LIKE '%Apoyo%' ORDER BY name")
  end

  def self.grouped_researchers(type)#adscriptions
    @adscriptions=find_by_sql("SELECT name FROM adscriptions WHERE is_enabled=true ORDER BY name")
    @position={'technician'=>(19..36).to_a+(63..80).to_a,
               'posdoc'=>38,
               'researcher'=>(1..12).to_a+[37,185]}
    @result = Hash.new
    @cad = Jobposition.most_recent_jp_join
    @adscriptions.map(&:name).each do |adsc|
      query = "SELECT distinct(users.id) FROM adscriptions
              JOIN user_adscriptions ON user_adscriptions.adscription_id = adscriptions.id
              JOIN users ON users.id = user_adscriptions.user_id"+ @cad +"WHERE users.userstatus_id=2 AND jobpositioncategory_id in (?) 
                     AND adscriptions.name = ?",@position[type], adsc
      tot = find_by_sql(query).length
      @result[adsc]=tot if tot!=0
    end
    @result
  end
end
