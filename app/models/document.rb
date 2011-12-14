class Document < ActiveRecord::Base
  validates_numericality_of :id, :allow_nil => true, :greater_than => 0, :only_integer => true
  validates_uniqueness_of :documenttype_id, :scope => [:user_id]
  belongs_to :user
  belongs_to :documenttype
  belongs_to :approved_by, :class_name => 'User'

  default_scope :order => 'documenttypes.start_date DESC, documenttypes.end_date DESC', :joins => :documenttype, :readonly => false

  scope :fullname_asc, joins(:user=>:person).order('people.lastname1 ASC, people.lastname2 ASC, people.firstname ASC')
  scope :annual_reports, joins(:documenttype).where("documenttypes.name LIKE 'Informe anual de actividades%'")
  scope :annual_plans, joins(:documenttype).where("documenttypes.name LIKE 'Plan de trabajo%'")

  scope :fullname_like, lambda { |fullname| where(" documents.user_id IN (#{Person.find_by_fullname(fullname).select('user_id').to_sql}) ") }
  scope :adscription_id_eq, lambda { |adscription_id| joins(:user=> :user_adscriptions).where(["user_adscriptions.adscription_id = ?", adscription_id] ) }

  search_methods :fullname_like, :adscription_id_eq

  before_create :file_path

  def url
    File.expand_path(file_path).gsub(File.expand_path(Rails.root.to_s+'/public'), '')
  end

  def file_path
    path = Rails.root.to_s + '/public/uploads'
    if !documenttype.name.match(/^Informe anual de actividades/).nil?
      path += '/annual_reports/' + documenttype.year.to_s
    elsif !documenttype.name.match(/^Plan de trabajo/).nil?
      path += '/annual_plans/' + documenttype.year.to_s
    end
    system "mkdir -p #{path}" unless File.exist? path

    unless user.nil?
      self.file = path + "/#{user.login}.pdf"
    else
      self.file.to_s
    end
  end

  def approve
    update_attribute(:approved, true)
  end

  def reject
    update_attribute(:approved, false)
  end
end
