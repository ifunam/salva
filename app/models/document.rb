class Document < ActiveRecord::Base
  validates_numericality_of :id, :allow_nil => true, :greater_than => 0, :only_integer => true
  validates_uniqueness_of :documenttype_id, :scope => [:user_id]
  belongs_to :user
  belongs_to :documenttype
  belongs_to :document_type
  belongs_to :approved_by, :class_name => 'User'

  # # attr_accessor :user_id, :ip_address, :documenttype_id, :file, :approved_by_id, :document_type_id
  # # attr_accessor :comments, :as => :academic
  # # attr_accessor :approved, :as => :academic

  scope :sort_by_documenttype, -> { order(documenttypes: { start_date: :desc, end_date: :desc }).joins([:documenttype], readonly: false) }
  scope :fullname_asc, -> { joins(:user=>:person).order('people.lastname1 ASC, people.lastname2 ASC, people.firstname ASC').sort_by_documenttype }
  scope :annual_reports, -> { joins(:documenttype).where("documenttypes.name LIKE 'Informe anual de actividades%'").sort_by_documenttype }
  scope :annual_plans, -> { joins(:documenttype).where("documenttypes.name LIKE 'Plan de trabajo%'").sort_by_documenttype }

  scope :fullname_like, lambda { |fullname|
    person_fullname_like_sql = Person.find_by_fullname(fullname).select('user_id').to_sql
    sql = "documents.user_id IN (#{person_fullname_like_sql})"
    where(sql)
  }
  scope :login_like, lambda { |login| joins(:user).where(:user => { :login.matches => "%#{login.downcase}%" }) }
  #scope :adscription_id_eq, lambda { |adscription_id| joins(:user=> :user_adscriptions).where(["user_adscriptions.adscription_id = ?", adscription_id] ) }
  scope :adscription_id_eq, lambda { |adscription_id|
    last_jp=find_by_sql("
    SELECT users.* FROM users
                 JOIN (
                 select user_adscriptions.* FROM user_adscriptions
              JOIN (select jobpositions.* from jobpositions join (select user_id,max(start_date) maxDate from jobpositions where institution_id=30 group by user_id) b
                           on jobpositions.user_id = b.user_id and jobpositions.start_date = b.maxDate) jobpositions
                           ON user_adscriptions.jobposition_id = jobpositions.id
                                ) as ad
                 ON ad.user_id=users.id
                 WHERE users.userstatus_id=2 and ad.adscription_id = "+adscription_id.to_s)
    joins(:user=> :user_adscription_records).includes(:documenttype,:user=>:person).where(["user_adscription_records.user_id in (?)", last_jp.map(&:id)]).uniq

  }
  scope :jobpositioncategory_id_eq, lambda { |jobpositioncategory_id|
    last_jp=find_by_sql("SELECT users.* FROM users
                 JOIN (select jobpositions.* from jobpositions
                   join (select user_id,max(start_date) maxDate from jobpositions where institution_id=30 group by user_id) b on jobpositions.user_id = b.user_id
                                and jobpositions.start_date = b.maxDate) as jp
                 ON jp.user_id=users.id
                 WHERE users.userstatus_id=2 and jp.jobpositioncategory_id = "+jobpositioncategory_id.to_s)
    joins(:user=> :jobpositions).includes(:documenttype,:user=>:person).where(["jobpositions.user_id in (?)", last_jp.map(&:id)]).uniq
  }
  scope :is_not_hidden, -> { where("is_hidden != 't' OR is_hidden IS NULL") }
  scope :year_eq, lambda { |y|
    joins(:documenttype).where("documenttypes.year = ?", y)
  }

  # search_methods :fullname_like, :login_like, :adscription_id_eq,
  #   :jobpositioncategory_id_eq, :year_eq

  before_create :file_path

  def self.paginated_search(params)
    is_not_hidden.fullname_asc.search(params[:search]).page(params[:page] || 1).per(params[:per_page] || 20)
  end

  def url
   File.expand_path(file_path).gsub(File.expand_path(Rails.root.to_s+'/public'), '')
  end

  def self.department_documents(adscription_id,year,name=nil,jobposition=nil)
    conditions = ''
    if name.nil? or name == "" or name.strip! == "" then
      usrs = UserAdscriptionRecord.current_adscription_users(adscription_id).map(&:user_id)
    else
      usrs = User.joins(:user_adscription).fullname_like(name).where('userstatus_id=2 AND user_adscriptions.adscription_id=?',adscription_id).map(&:id)
    end
    unless usrs==[]
      conditions += " AND users.id in ("
      usrs.each{|u| conditions += u.to_s+","}
      conditions.chop!
      conditions += ")"
    else
      conditions += " AND users.id IS null"
    end
    if jobposition.nil? or jobposition.strip == ""
      joins(:user).includes(:documenttype).where('documenttypes.year=?'+conditions,year).order("users.author_name")
    else
      joins(:user).includes(:documenttype).where('documenttypes.year=?'+conditions,year).jobpositioncategory_id_eq(jobposition).order("users.author_name")
    end
  end

  def new_file_path
    if document_type_id.nil?
    path = Rails.root.to_s + '/app/files'
    if !documenttype.name.match(/^Informe anual de actividades/).nil?
      path += '/annual_reports/' + documenttype.year.to_s
    elsif !documenttype.name.match(/^Plan de trabajo/).nil?
      path += '/annual_plans/' + documenttype.year.to_s
    end
    path += file_path[file_path.rindex('/'),file_path.size]
    end
  end

  def file_path
    if document_type_id.nil?
    path = Rails.root.to_s + '/public/uploads'
    new_path = Rails.root.to_s + '/app/files'
    if !documenttype.name.match(/^Informe anual de actividades/).nil?
      path += '/annual_reports/' + documenttype.year.to_s
      new_path += '/annual_reports/' + documenttype.year.to_s
    elsif !documenttype.name.match(/^Plan de trabajo/).nil?
      path += '/annual_plans/' + documenttype.year.to_s
      new_path += '/annual_plans/' + documenttype.year.to_s
    end
    system "mkdir -p #{path}" unless File.exist? path
    system "mkdir -p #{new_path}" unless File.exist? new_path

    unless user.nil?
      self.file = path + "/#{user.login}.pdf"
    else
      self.file.to_s
    end
    end
  end

  def approve
    update_attribute(:approved, true)
  end

  def reject
    update_attribute(:approved, false)
  end

  def approved_by_fullname
    approved_by.fullname_or_email unless approved_by_id.nil?
  end

  def unlock!
    doc = AnnualPlan.where(:user_id => user_id, :documenttype_id => documenttype_id).first
    doc.update_attribute(:delivered, false) unless doc.nil?
    update_attribute(:approved, false)
  end
end
