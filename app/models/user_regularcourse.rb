class UserRegularcourse < ActiveRecord::Base
  # attr_accessor :user_id, :period_id, :roleinregularcourse_id, :hoursxweek, :regularcourse_id, :registered_by_id
  validates_presence_of     :period_id
  validates_numericality_of :id, :allow_nil => true, :only_integer => true
  validates_numericality_of :period_id, :roleinregularcourse_id, :greater_than => 0, :only_integer => true
  validates_numericality_of :hoursxweek, :allow_nil => true, :greater_than => 0 , :only_integer => true
  validates_inclusion_of    :hoursxweek, :in => 1..40, :allow_nil => true
  validates_uniqueness_of :regularcourse_id, :scope => [:period_id, :user_id]

  belongs_to :regularcourse
  belongs_to :period
  belongs_to :roleinregularcourse
  belongs_to :user
  belongs_to :registered_by, :class_name => 'User', :foreign_key => 'registered_by_id'
  belongs_to :modified_by, :class_name => 'User', :foreign_key => 'modified_by_id'

  default_scope -> { includes(:period, :regularcourse).order(periods: { enddate: :desc }, regularcourses: { title: :asc }) }
  scope :since, lambda { |date| includes(:period, :regularcourse).where("user_regularcourses.period_id IN (#{Period.select('id').where({:startdate.gteq => date}).to_sql})") }
  scope :until, lambda { |date| includes(:period, :regularcourse).where("user_regularcourses.period_id IN (#{Period.select('id').where({:enddate.lteq => date}).to_sql})") }
  scope :find_by_year, lambda { |year| since("#{year}-01-01").until("#{year}-12-31") }
  scope :bachelor_degree, -> { joins(:regularcourse => {:academicprogram => :career}).where("careers.degree_id = ?", 3) }
  scope :master_degree, -> { joins(:regularcourse => {:academicprogram => :career}).where("careers.degree_id = ?", 5) }
  scope :phd_degree, -> { joins(:regularcourse => {:academicprogram => :career}).where("careers.degree_id = ?", 6) }
  scope :specialized, -> { joins(:regularcourse => {:academicprogram => :career}).where("careers.degree_id = ?", 4) }
  scope :highschool, -> { joins(:regularcourse => {:academicprogram => :career}).where("careers.degree_id = ?", 1) }
  scope :technical, -> { joins(:regularcourse => {:academicprogram => :career}).where("careers.degree_id = ?", 2) }
  scope :degree_id, lambda { |id| joins(:regularcourse => {:academicprogram => :career}).where("careers.degree_id = ?", id) }
  scope :regularcourse_id_by_user_id, lambda { |user_id|  select('DISTINCT(regularcourse_id)').joins(:period).where(:user_id => user_id) }
  scope :regularcourse_id_not_eq_user_id, lambda { |user_id|  select('DISTINCT(regularcourse_id)').where("user_regularcourses.user_id != ?", user_id) }
  scope :adscription_id, lambda { |id| joins(:user => :user_adscription).where(:user => { :user_adscription => { :adscription_id => id} }) }

  # search_methods :find_by_year, :degree_id, :adscription_id

  def to_s
    ["#{roleinregularcourse.name}: #{regularcourse.to_s}", "Horas por semana: #{hoursxweek}", "Periodo escolar: #{period.title}"].join(', ')
  end

  def role_and_period_and_hours
    ["Rol: #{roleinregularcourse.name}", "Periodo: #{period.title}", "Horas x semana: #{hoursxweek}"].join(', ')
  end

  def teacher_with_role
    [user.author_name, "(#{role_and_period_and_hours})"].join(' ')
  end

  def self.grouped_courses(adsc_year)
    @years = [(adsc_year[:year]).to_s+'-2',(adsc_year[:year]+1).to_s+'-1']
    query = "SELECT distinct(regularcourses.id,users.id,periods.id) FROM user_regularcourses
             JOIN users ON user_regularcourses.user_id=users.id
             JOIN user_adscription_records ON users.id=user_adscription_records.user_id
             JOIN adscriptions ON user_adscription_records.adscription_id=adscriptions.id
             JOIN regularcourses ON user_regularcourses.regularcourse_id = regularcourses.id
             JOIN periods ON user_regularcourses.period_id=periods.id
             JOIN academicprograms ON regularcourses.academicprogram_id=academicprograms.id
             JOIN degrees ON academicprograms.degree_id=degrees.id
             WHERE degrees.name in (?) AND adscriptions.name=? AND 
             periods.title in (?)",
              adsc_year[:deg], adsc_year[:adsc],  @years
    res = find_by_sql(query)
    if adsc_year[:deg][0] == 'Licenciatura' then
      query = "SELECT distinct(regularcourses.id,users.id,periods.id) FROM user_regularcourses
               JOIN users ON user_regularcourses.user_id=users.id
               JOIN user_adscription_records ON users.id=user_adscription_records.user_id
               JOIN adscriptions ON user_adscription_records.adscription_id=adscriptions.id
               JOIN regularcourses ON user_regularcourses.regularcourse_id = regularcourses.id
               JOIN periods ON user_regularcourses.period_id=periods.id
               JOIN academicprograms ON regularcourses.academicprogram_id=academicprograms.id
               WHERE academicprograms.degree_id is NULL
                     AND adscriptions.name=? AND 
                     periods.title in (?)", 
                     adsc_year[:adsc],  @years
      res += find_by_sql(query)
    end
    res
  end

end
